import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final FlutterTts _tts = FlutterTts();

  bool isPlaying = false;
  bool showTranscript = false;
  int selectedAnswer = -1;
  int score = 0;
  double speed = 1.0;

  final String conversation =
      'Anna: Hi David! How are you today?\n\n'
      'David: I am great, thanks. I am going to the library after work.\n\n'
      'Anna: Really? What are you going to study?\n\n'
      'David: I am studying English because I want to improve my speaking skills.\n\n'
      'Anna: That sounds great. Good luck!\n\n'
      'David: Thank you!';

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Where is David going after work?',
      'answers': [
        'To the gym',
        'To the library',
        'To the restaurant',
        'To the airport',
      ],
      'correct': 1,
    },
    {
      'question': 'What does David want to improve?',
      'answers': [
        'His writing',
        'His reading',
        'His speaking skills',
        'His pronunciation only',
      ],
      'correct': 2,
    },
    {
      'question': 'Why is David studying English?',
      'answers': [
        'Because he has an exam',
        'Because he wants to improve his speaking',
        'Because his friend asked him',
        'Because he is traveling today',
      ],
      'correct': 1,
    },
  ];

  @override
  void initState() {
    super.initState();

    _tts.setLanguage('en-US');
    _tts.setPitch(1.0);

    _tts.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        isPlaying = true;
      });
    });

    _tts.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        isPlaying = false;
      });
    });

    _tts.setCancelHandler(() {
      if (!mounted) return;

      setState(() {
        isPlaying = false;
      });
    });
  }

  Future<void> playConversation() async {
    if (isPlaying) {
      await _tts.stop();

      if (!mounted) return;

      setState(() {
        isPlaying = false;
      });

      return;
    }

    await _tts.setSpeechRate(0.45 * speed);
    await _tts.speak(conversation);
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    final question = questions[questionIndex];

    if (question['selected'] != null) {
      return;
    }

    setState(() {
      question['selected'] = answerIndex;

      if (answerIndex == question['correct']) {
        score++;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      score = 0;
      selectedAnswer = -1;

      for (final question in questions) {
        question.remove('selected');
      }
    });
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Listening'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.headphones,
                size: 75,
                color: colorScheme.primary,
              ),

              const SizedBox(height: 15),

              const Text(
                'AI Listening',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Listen, understand and test your comprehension.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.smart_toy,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'AI Conversation',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Listen to the conversation carefully.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 20),

                      IconButton(
                        onPressed: playConversation,
                        iconSize: 80,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        isPlaying
                            ? 'Playing...'
                            : 'Press Play',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Playback Speed',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Slider(
                value: speed,
                min: 0.5,
                max: 1.5,
                divisions: 4,
                label: '${speed.toStringAsFixed(1)}x',
                onChanged: (value) {
                  setState(() {
                    speed = value;
                  });
                },
              ),

              Text(
                '${speed.toStringAsFixed(1)}x',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    showTranscript = !showTranscript;
                  });
                },
                icon: Icon(
                  showTranscript
                      ? Icons.visibility_off
                      : Icons.description,
                ),
                label: Text(
                  showTranscript
                      ? 'Hide Transcript'
                      : 'Show Transcript',
                ),
              ),

              if (showTranscript) ...[
                const SizedBox(height: 15),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Text(
                      conversation,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 30),

              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Comprehension Quiz',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '$score / ${questions.length}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              ...List.generate(
                questions.length,
                (questionIndex) {
                  final question =
                      questions[questionIndex];

                  final answers =
                      question['answers'] as List<String>;

                  final correct =
                      question['correct'] as int;

                  final selected =
                      question['selected'] as int?;

                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: 18,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '${questionIndex + 1}. ${question['question']}',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 14),

                          ...List.generate(
                            answers.length,
                            (answerIndex) {
                              final isCorrect =
                                  selected != null &&
                                  answerIndex == correct;

                              final isWrong =
                                  selected != null &&
                                  answerIndex == selected &&
                                  answerIndex != correct;

                              return Container(
                                margin:
                                    const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: OutlinedButton(
                                  onPressed: selected != null
                                      ? null
                                      : () {
                                          selectAnswer(
                                            questionIndex,
                                            answerIndex,
                                          );
                                        },
                                  style: OutlinedButton.styleFrom(
                                    padding:
                                        const EdgeInsets.all(14),
                                    alignment:
                                        Alignment.centerLeft,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          answers[answerIndex],
                                          style:
                                              const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      if (isCorrect)
                                        const Icon(
                                          Icons.check_circle,
                                        ),
                                      if (isWrong)
                                        const Icon(
                                          Icons.cancel,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              if (questions.every(
                (question) => question['selected'] != null,
              ))
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.emoji_events,
                          size: 60,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Quiz Completed!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Your score: $score / ${questions.length}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 15),

                        ElevatedButton.icon(
                          onPressed: resetQuiz,
                          icon: const Icon(Icons.refresh),
                          label: const Text(
                            'Try Again',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
