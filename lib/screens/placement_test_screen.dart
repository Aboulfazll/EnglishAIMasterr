import 'package:flutter/material.dart';

class PlacementTestScreen extends StatefulWidget {
  const PlacementTestScreen({super.key});

  @override
  State<PlacementTestScreen> createState() =>
      _PlacementTestScreenState();
}

class _PlacementTestScreenState
    extends State<PlacementTestScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedAnswer;

  final questions = [
    {
      'question': 'I ___ a student.',
      'answers': ['am', 'is', 'are', 'be'],
      'correct': 0,
    },
    {
      'question': 'She ___ to school every day.',
      'answers': ['go', 'goes', 'going', 'gone'],
      'correct': 1,
    },
    {
      'question': 'I have lived here ___ 2020.',
      'answers': ['for', 'since', 'from', 'during'],
      'correct': 1,
    },
    {
      'question': 'If I had more time, I ___ another language.',
      'answers': ['learn', 'will learn', 'would learn', 'learned'],
      'correct': 2,
    },
    {
      'question': 'By the time we arrived, the movie ___.',
      'answers': [
        'started',
        'has started',
        'had started',
        'starts'
      ],
      'correct': 2,
    },
    {
      'question':
          'The proposal was rejected because it was considered ___.',
      'answers': [
        'feasible',
        'redundant',
        'impractical',
        'adequate'
      ],
      'correct': 2,
    },
  ];

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == questions[currentQuestion]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        answered = false;
        selectedAnswer = null;
      });
    } else {
      showResult();
    }
  }

  void showResult() {
    String level;

    if (score <= 1) {
      level = 'A1';
    } else if (score == 2) {
      level = 'A2';
    } else if (score == 3) {
      level = 'B1';
    } else if (score == 4) {
      level = 'B2';
    } else if (score == 5) {
      level = 'C1';
    } else {
      level = 'C2';
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Your Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 70,
              ),
              const SizedBox(height: 15),
              Text(
                'Score: $score / ${questions.length}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Estimated Level: $level',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Finish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final answers = question['answers'] as List<String>;
    final correct = question['correct'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement Test'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestion + 1} / ${questions.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value:
                  (currentQuestion + 1) / questions.length,
            ),

            const SizedBox(height: 35),

            Text(
              question['question'] as String,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ...List.generate(
              answers.length,
              (index) {
                final isCorrect =
                    answered && index == correct;
                final isWrong =
                    answered &&
                    selectedAnswer == index &&
                    index != correct;

                return Card(
                  margin:
                      const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      answers[index],
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    trailing: isCorrect
                        ? const Icon(Icons.check)
                        : isWrong
                            ? const Icon(Icons.close)
                            : null,
                    onTap: () => selectAnswer(index),
                  ),
                );
              },
            ),

            const Spacer(),

            if (answered)
              ElevatedButton(
                onPressed: nextQuestion,
                child: Text(
                  currentQuestion ==
                          questions.length - 1
                      ? 'Show Result'
                      : 'Next Question',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
