import 'package:flutter/material.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedAnswer;

  final questions = [
    {
      'question': 'She ___ to school every day.',
      'answers': ['go', 'goes', 'going', 'gone'],
      'correct': 1,
      'level': 'A1',
    },
    {
      'question': 'They ___ watching TV right now.',
      'answers': ['is', 'are', 'am', 'be'],
      'correct': 1,
      'level': 'A2',
    },
    {
      'question': 'I ___ this book before.',
      'answers': ['read', 'have read', 'am reading', 'reads'],
      'correct': 1,
      'level': 'B1',
    },
    {
      'question': 'If I had money, I ___ a new car.',
      'answers': ['buy', 'will buy', 'would buy', 'bought'],
      'correct': 2,
      'level': 'B2',
    },
    {
      'question': 'By the time he arrived, we ___ dinner.',
      'answers': [
        'finish',
        'have finished',
        'had finished',
        'finishing'
      ],
      'correct': 2,
      'level': 'C1',
    },
    {
      'question':
          'Had I known about the problem, I ___ earlier.',
      'answers': [
        'would have acted',
        'will act',
        'act',
        'would act'
      ],
      'correct': 0,
      'level': 'C2',
    },
  ];

  void chooseAnswer(int index) {
    if (selectedAnswer != null) return;

    setState(() {
      selectedAnswer = index;

      if (index == questions[currentQuestion]['correct']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
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
          title: const Text('Grammar Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.school,
                size: 65,
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
                'Level: $level',
                style: const TextStyle(
                  fontSize: 26,
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
        title: const Text('Grammar'),
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

            const SizedBox(height: 30),

            Text(
              question['level'] as String,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .colorScheme
                    .primary,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              question['question'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ...List.generate(
              answers.length,
              (index) {
                final isCorrect =
                    selectedAnswer != null &&
                    index == correct;

                final isWrong =
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
                    onTap: () => chooseAnswer(index),
                  ),
                );
              },
            ),

            const Spacer(),

            if (selectedAnswer != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  child: Text(
                    currentQuestion ==
                            questions.length - 1
                        ? 'Show Result'
                        : 'Next',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
