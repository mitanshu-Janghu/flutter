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
  bool isCameraReady = false;

  late FaceDetector faceDetector;

  int faceCount = 0;

  bool processing = false;

  @override
  void initState() {
    super.initState();

    faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableContours: true,
        enableClassification: true,
      ),
    );

    initCamera();
  }

  Future<void> initCamera() async {

    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();

    startStream();

    setState(() {
      isCameraReady = true;
    });
  }

  void startStream() {

    controller!.startImageStream((CameraImage image) async {

      if (processing) return;
      processing = true;

      try {

        final camera = controller!.description;

        final rotation =
            InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
                InputImageRotation.rotation0deg;

        final format =
            InputImageFormatValue.fromRawValue(image.format.raw) ??
                InputImageFormat.yuv420;

        final inputImage = InputImage.fromBytes(
          bytes: image.planes.first.bytes,
          metadata: InputImageMetadata(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            rotation: rotation,
            format: format,
            bytesPerRow: image.planes.first.bytesPerRow,
          ),
        );

        final faces = await faceDetector.processImage(inputImage);

        print("Faces detected: ${faces.length}");

        if (mounted) {
          setState(() {
            faceCount = faces.length;
          });
        }

      } catch (e, stack) {

        print("Face detection error: $e");
        print(stack);

      }

      processing = false;

    });

  }

  @override
  void dispose() {
    controller?.dispose();
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!isCameraReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [

          CameraPreview(controller!),

          Positioned(
            top: 60,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black54,
              child: Text(
                "Faces detected: $faceCount",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}