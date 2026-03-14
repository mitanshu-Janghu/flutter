import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  String? selectedSubject;
  String? selectedChapter;

  int questionIndex = 0;
  bool quizStarted = false;

  Map<String, List<String>> chapters = {

    "Physics": [
      "Units and Measurements",
      "Motion in a Straight Line",
      "Laws of Motion",
      "Work Energy Power",
      "Gravitation",
      "Thermodynamics",
      "Oscillations",
      "Waves",
      "Electrostatics",
      "Current Electricity",
      "Magnetism",
      "Electromagnetic Induction",
      "Alternating Current",
      "Optics",
      "Dual Nature of Matter",
      "Atoms",
      "Nuclei",
      "Semiconductors"
    ],

    "Chemistry": [
      "Some Basic Concepts of Chemistry",
      "Structure of Atom",
      "Periodic Classification",
      "Chemical Bonding",
      "States of Matter",
      "Thermodynamics",
      "Equilibrium",
      "Redox Reactions",
      "Hydrogen",
      "s Block Elements",
      "p Block Elements",
      "Organic Chemistry Basics",
      "Hydrocarbons",
      "Solid State",
      "Solutions",
      "Electrochemistry",
      "Chemical Kinetics",
      "Surface Chemistry",
      "Metallurgy",
      "Haloalkanes",
      "Alcohols Phenols Ethers",
      "Aldehydes Ketones",
      "Amines",
      "Biomolecules",
      "Polymers"
    ],

    "Math": [
      "Sets",
      "Relations and Functions",
      "Trigonometric Functions",
      "Complex Numbers",
      "Quadratic Equations",
      "Permutations and Combinations",
      "Binomial Theorem",
      "Sequences and Series",
      "Straight Lines",
      "Conic Sections",
      "Limits and Derivatives",
      "Statistics",
      "Probability",
      "Matrices",
      "Determinants",
      "Continuity and Differentiability",
      "Applications of Derivatives",
      "Integrals",
      "Differential Equations",
      "Vectors",
      "3D Geometry",
      "Linear Programming"
    ],

    "Biology": [
      "The Living World",
      "Biological Classification",
      "Plant Kingdom",
      "Animal Kingdom",
      "Morphology of Flowering Plants",
      "Cell Structure",
      "Cell Cycle",
      "Photosynthesis",
      "Respiration in Plants",
      "Plant Growth",
      "Human Physiology",
      "Reproduction",
      "Genetics",
      "Evolution",
      "Biology in Human Welfare",
      "Biotechnology",
      "Ecology"
    ]
  };

  List<Map<String, dynamic>> questions = [];

  void generateQuestions() {

    questions = List.generate(5, (index) {
      return {
        "question":
            "Sample Question ${index + 1} from $selectedChapter?",
        "options": [
          "Option A",
          "Option B",
          "Option C",
          "Option D"
        ],
        "answer": 0
      };
    });

    setState(() {
      quizStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (!quizStarted) {
      return Scaffold(
        appBar: AppBar(title: const Text("Select Quiz")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 20),

              DropdownButtonFormField(
                hint: const Text("Select Subject"),
                value: selectedSubject,
                items: ["Physics","Chemistry","Math","Biology"]
                    .map((subject) => DropdownMenuItem(
                          value: subject,
                          child: Text(subject),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSubject = value;
                    selectedChapter = null;
                  });
                },
              ),

              const SizedBox(height: 20),

              if (selectedSubject != null)
                DropdownButtonFormField(
                  hint: const Text("Select Chapter"),
                  value: selectedChapter,
                  items: chapters[selectedSubject]!
                      .map((chapter) => DropdownMenuItem(
                            value: chapter,
                            child: Text(chapter),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedChapter = value;
                    });
                  },
                ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: selectedChapter == null
                    ? null
                    : () {
                        generateQuestions();
                      },
                child: const Text("Start Quiz"),
              )
            ],
          ),
        ),
      );
    }

    var question = questions[questionIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Question ${questionIndex + 1}/5")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              question["question"],
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            ...List.generate(4, (i) {
              return ListTile(
                title: Text(question["options"][i]),
                leading: const Icon(Icons.circle_outlined),
                onTap: () {

                  if (questionIndex < 4) {
                    setState(() {
                      questionIndex++;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Quiz Completed"),
                        content: const Text("Great Job!"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  quizStarted = false;
                                  questionIndex = 0;
                                });
                              },
                              child: const Text("Restart"))
                        ],
                      ),
                    );
                  }

                },
              );
            })
          ],
        ),
      ),
    );
  }
}