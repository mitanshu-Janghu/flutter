import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'dart:ui';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController? controller;
  bool cameraReady = false;
  bool processing = false;

  int faceCount = 0;
  String sleepy = "No";

  late FaceDetector faceDetector;

  @override
  void initState() {
    super.initState();

    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        enableClassification: true, // needed for eye detection
      ),
    );

    startCamera();
  }

  Future<void> startCamera() async {

    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    await controller!.initialize();

    controller!.startImageStream(processImage);

    setState(() {
      cameraReady = true;
    });
  }

  Future<void> processImage(CameraImage image) async {

    if (processing) return;
    processing = true;

    try {

      final rotation =
          InputImageRotationValue.fromRawValue(
            controller!.description.sensorOrientation,
          ) ??
          InputImageRotation.rotation0deg;

      final inputImage = InputImage.fromBytes(
        bytes: image.planes.first.bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: InputImageFormat.nv21,
          bytesPerRow: image.planes.first.bytesPerRow,
        ),
      );

      final faces = await faceDetector.processImage(inputImage);

      if (faces.isNotEmpty) {

        final face = faces.first;

        double? leftEye = face.leftEyeOpenProbability;
        double? rightEye = face.rightEyeOpenProbability;

        if (leftEye != null && rightEye != null) {

          if (leftEye < 0.35 && rightEye < 0.35) {
            sleepy = "Yes";
          } else {
            sleepy = "No";
          }

        }

      }

      if (mounted) {
        setState(() {
          faceCount = faces.length;
        });
      }

    } catch (e) {
      debugPrint("Face detection error: $e");
    }

    processing = false;
  }

  @override
  void dispose() {
    controller?.dispose();
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!cameraReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [

          CameraPreview(controller!),

          Positioned(
            top: 80,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Faces detected: $faceCount",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Sleepy: $sleepy",
                    style: const TextStyle(
                        color: Colors.yellow, fontSize: 18),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}