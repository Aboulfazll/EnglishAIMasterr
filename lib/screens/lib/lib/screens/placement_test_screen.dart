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
  bool finished = false;

  final List<_Question> questions = [
    _Question(
      question: 'Choose the correct sentence:',
      options: [
        'She go to school every day.',
        'She goes to school every day.',
        'She going to school every day.',
        'She gone to school every day.',
      ],
      correctAnswer: 1,
    ),
    _Question(
      question: 'What is the opposite of "expensive"?',
      options: [
        'Cheap',
        'Large',
        'Heavy',
        'Difficult',
      ],
      correctAnswer: 0,
    ),
    _Question(
      question: 'I _____ coffee every morning.',
      options: [
        'drink',
        'drinks',
        'drinking',
        'drank',
      ],
      correctAnswer: 0,
    ),
    _Question(
      question: 'Which word means "to begin"?',
      options: [
        'Finish',
        'Start',
        'Forget',
        'Leave',
      ],
      correctAnswer: 1,
    ),
    _Question(
      question: 'If I have time tomorrow, I _____ you.',
      options: [
        'visit',
        'visited',
        'will visit',
        'visiting',
      ],
      correctAnswer: 2,
    ),
    _Question(
      question: 'Choose the most natural sentence:',
      options: [
        'I have lived here since five years.',
        'I live here since five years.',
        'I have been living here for five years.',
        'I am living here since five years.',
      ],
      correctAnswer: 2,
    ),
    _Question(
      question: 'What does "reliable" mean?',
      options: [
        'Easy to break',
        'Can be trusted',
        'Very expensive',
        'Difficult to understand',
      ],
      correctAnswer: 1,
    ),
    _Question(
      question: 'By the time we arrived, the movie _____.',
      options: [
        'starts',
        'has started',
        'had started',
        'starting',
      ],
      correctAnswer: 2,
    ),
    _Question(
      question: 'Which sentence is grammatically correct?',
      options: [
        'Despite of the rain, we went out.',
        'Despite the rain, we went out.',
        'Despite it was raining, we went out.',
        'Despite raining was heavy, we went out.',
      ],
      correctAnswer: 1,
    ),
    _Question(
      question: 'The word "significant" is closest in meaning to:',
      options: [
        'Unimportant',
        'Temporary',
        'Important',
        'Ordinary',
      ],
      correctAnswer: 2,
    ),
    _Question(
      question: 'Had I known about the problem, I _____ differently.',
      options: [
        'would have acted',
        'will act',
        'act',
        'would act',
      ],
      correctAnswer: 0,
    ),
    _Question(
      question:
          'Choose the most appropriate formal expression:',
      options: [
        'Give me the information.',
        'I want the information now.',
        'Could you please provide the requested information?',
        'Send it to me.',
      ],
      correctAnswer: 2,
    ),
  ];

  void selectAnswer(int index) {
    if (answered) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == questions[currentQuestion].correctAnswer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (!answered) return;

    if (currentQuestion == questions.length - 1) {
      setState(() {
        finished = true;
      });
      return;
    }

    setState(() {
      currentQuestion++;
      answered = false;
      selectedAnswer = null;
    });
  }

  void restartTest() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      answered = false;
      selectedAnswer = null;
      finished = false;
    });
  }

  String getLevel() {
    final percentage =
        (score / questions.length) * 100;

    if (percentage <= 25) {
      return 'A1';
    }

    if (percentage <= 40) {
      return 'A2';
    }

    if (percentage <= 55) {
      return 'B1';
    }

    if (percentage <= 70) {
      return 'B2';
    }

    if (percentage <= 85) {
      return 'C1';
    }

    return 'C2';
  }

  String getLevelDescription() {
    switch (getLevel()) {
      case 'A1':
        return 'Beginner';
      case 'A2':
        return 'Elementary';
      case 'B1':
        return 'Intermediate';
      case 'B2':
        return 'Upper-Intermediate';
      case 'C1':
        return 'Advanced';
      default:
        return 'Proficient';
    }
  }

  Color answerColor(
    int index,
    ColorScheme colors,
  ) {
    if (!answered) {
      return colors.surfaceContainerHighest;
    }

    if (index == questions[currentQuestion].correctAnswer) {
      return Colors.green.withValues(alpha: 0.18);
    }

    if (index == selectedAnswer) {
      return colors.errorContainer;
    }

    return colors.surfaceContainerHighest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placement Test'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: finished
            ? _buildResult()
            : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final question = questions[currentQuestion];
    final colors = Theme.of(context).colorScheme;

    final progress =
        (currentQuestion + 1) / questions.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 5),

          Icon(
            Icons.assessment_outlined,
            size: 65,
            color: colors.primary,
          ),

          const SizedBox(height: 12),

          const Text(
            'Find Your English Level',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'Answer the questions to estimate your CEFR level.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${currentQuestion + 1}/${questions.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Text(
                question.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          ...List.generate(
            question.options.length,
            (index) {
              final isCorrect =
                  index == question.correctAnswer;
              final isSelected =
                  index == selectedAnswer;

              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(15),
                  onTap: () => selectAnswer(index),
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 200),
                    padding:
                        const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: answerColor(
                        index,
                        colors,
                      ),
                      borderRadius:
                          BorderRadius.circular(15),
                      border: Border.all(
                        color: answered && isCorrect
                            ? Colors.green
                            : answered && isSelected
                                ? colors.error
                                : colors.outlineVariant,
                        width: 1.3,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              colors.primaryContainer,
                          child: Text(
                            String.fromCharCode(
                              65 + index,
                            ),
                            style: TextStyle(
                              color: colors
                                  .onPrimaryContainer,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ),
                        if (answered && isCorrect)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        else if (answered &&
                            isSelected)
                          Icon(
                            Icons.cancel,
                            color: colors.error,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          if (answered) ...[
            const SizedBox(height: 8),

            Card(
              color: selectedAnswer ==
                      question.correctAnswer
                  ? colors.primaryContainer
                  : colors.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(
                      selectedAnswer ==
                              question.correctAnswer
                          ? Icons.check_circle
                          : Icons.info_outline,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedAnswer ==
                                question.correctAnswer
                            ? 'Correct! Great job.'
                            : 'Not quite. The correct answer is: ${question.options[question.correctAnswer]}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: nextQuestion,
                child: Text(
                  currentQuestion ==
                          questions.length - 1
                      ? 'See My Result'
                      : 'Next Question',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResult() {
    final colors = Theme.of(context).colorScheme;
    final level = getLevel();
    final percentage =
        ((score / questions.length) * 100).round();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.emoji_events,
              size: 90,
              color: colors.primary,
            ),

            const SizedBox(height: 18),

            const Text(
              'Test Complete!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Your estimated English level is:',
              style: TextStyle(
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryContainer,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    level,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  Text(
                    getLevelDescription(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Your Score',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$score / ${questions.length}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('$percentage% correct'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Based on this test, we recommend starting around level $level.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: restartTest,
                icon: const Icon(Icons.refresh),
                label: const Text('Take Test Again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  const _Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
