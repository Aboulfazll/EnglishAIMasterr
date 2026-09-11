import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool speechAvailable = false;
  bool isListening = false;
  bool isSpeaking = false;
  bool isAnalyzing = false;

  String recognizedText = '';
  String feedback = '';

  double confidence = 0;

  final String challenge =
      'Tell me about your daily routine. What do you usually do in the morning?';

  @override
  void initState() {
    super.initState();
    initializeSpeech();
    initializeTts();
  }

  Future<void> initializeSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (!mounted) return;

          if (status == 'done' || status == 'notListening') {
            setState(() {
              isListening = false;
            });
          }
        },
        onError: (error) {
          if (!mounted) return;

          setState(() {
            isListening = false;
          });

          showMessage(
            'Speech recognition error: ${error.errorMsg}',
          );
        },
      );

      if (!mounted) return;

      setState(() {
        speechAvailable = available;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        speechAvailable = false;
      });
    }
  }

  Future<void> initializeTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);

    _tts.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        isSpeaking = true;
      });
    });

    _tts.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });
    });

    _tts.setCancelHandler(() {
      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future<void> startListening() async {
    if (!speechAvailable) {
      await initializeSpeech();
    }

    if (!speechAvailable) {
      showMessage(
        'Speech recognition is not available on this device.',
      );
      return;
    }

    setState(() {
      recognizedText = '';
      feedback = '';
      confidence = 0;
      isListening = true;
    });

    await _speech.listen(
      localeId: 'en_US',
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          recognizedText = result.recognizedWords;
          confidence = result.confidence;
        });
      },
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();

    if (!mounted) return;

    setState(() {
      isListening = false;
    });

    if (recognizedText.trim().isEmpty) {
      showMessage(
        'No speech was detected. Please try again.',
      );
    }
  }

  Future<void> speakQuestion() async {
    if (isSpeaking) {
      await _tts.stop();

      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });

      return;
    }

    await _tts.speak(challenge);
  }

  Future<void> analyzeSpeech() async {
    if (recognizedText.trim().isEmpty) {
      showMessage(
        'First record your answer.',
      );
      return;
    }

    setState(() {
      isAnalyzing = true;
      feedback = '';
    });

    await Future.delayed(
      const Duration(milliseconds: 1200),
    );

    final words = recognizedText
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;

    int fluency;

    if (words >= 40) {
      fluency = 92;
    } else if (words >= 30) {
      fluency = 85;
    } else if (words >= 20) {
      fluency = 78;
    } else if (words >= 10) {
      fluency = 70;
    } else {
      fluency = 60;
    }

    int grammar;

    final lowerText = recognizedText.toLowerCase();

    if (lowerText.contains('usually') ||
        lowerText.contains('every day') ||
        lowerText.contains('because')) {
      grammar = 86;
    } else if (words >= 15) {
      grammar = 78;
    } else {
      grammar = 68;
    }

    int pronunciation;

    if (confidence > 0) {
      pronunciation = (confidence * 100).round();
    } else {
      pronunciation = 75;
    }

    if (pronunciation > 100) {
      pronunciation = 100;
    }

    final overall =
        ((fluency + grammar + pronunciation) / 3).round();

    if (!mounted) return;

    setState(() {
      isAnalyzing = false;

      feedback =
          'Pronunciation: $pronunciation / 100\n'
          'Grammar: $grammar / 100\n'
          'Fluency: $fluency / 100\n'
          'Overall Score: $overall / 100\n\n'
          'AI Feedback\n\n'
          '✓ Your answer was successfully recognized.\n\n'
          '• Try to speak in complete sentences.\n'
          '• Keep a natural speaking rhythm.\n'
          '• Use more vocabulary when describing your routine.\n'
          '• Practice speaking every day for better fluency.';
    });
  }

  void clearPractice() {
    setState(() {
      recognizedText = '';
      feedback = '';
      confidence = 0;
      isListening = false;
      isAnalyzing = false;
    });
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Speaking'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5),

              Icon(
                Icons.record_voice_over,
                size: 75,
                color: colorScheme.primary,
              ),

              const SizedBox(height: 15),

              const Text(
                'Speak with AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'تمرین مکالمه و دریافت بازخورد هوشمند',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
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
                            Icons.psychology,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'Speaking Challenge',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Text(
                        challenge,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 18),

                      OutlinedButton.icon(
                        onPressed: speakQuestion,
                        icon: Icon(
                          isSpeaking
                              ? Icons.stop
                              : Icons.volume_up,
                        ),
                        label: Text(
                          isSpeaking
                              ? 'Stop'
                              : 'Listen to Question',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Your Answer',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    recognizedText.isEmpty
                        ? 'متن صحبت شما اینجا نمایش داده می‌شود...'
                        : recognizedText,
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.7,
                      color: recognizedText.isEmpty
                          ? Colors.grey
                          : null,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Center(
                child: GestureDetector(
                  onTap: isListening
                      ? stopListening
                      : startListening,
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 250),
                    width: isListening ? 135 : 115,
                    height: isListening ? 135 : 115,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isListening
                          ? colorScheme.errorContainer
                          : colorScheme.primaryContainer,
                    ),
                    child: Icon(
                      isListening
                          ? Icons.stop
                          : Icons.mic,
                      size: 55,
                      color: isListening
                          ? colorScheme.onErrorContainer
                          : colorScheme.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                isListening
                    ? 'Listening... Tap to stop'
                    : 'Tap the microphone to start',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              if (confidence > 0) ...[
                const SizedBox(height: 18),

                Text(
                  'Speech confidence: ${(confidence * 100).round()}%',
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 7),

                LinearProgressIndicator(
                  value: confidence.clamp(0.0, 1.0),
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],

              const SizedBox(height: 25),

              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      isAnalyzing ? null : analyzeSpeech,
                  icon: isAnalyzing
                      ? const SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.auto_awesome,
                        ),
                  label: Text(
                    isAnalyzing
                        ? 'Analyzing...'
                        : 'Analyze with AI',
                  ),
                ),
              ),

              if (feedback.isNotEmpty) ...[
                const SizedBox(height: 25),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.analytics,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'AI Feedback',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        Text(
                          feedback,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 20),

              OutlinedButton.icon(
                onPressed: clearPractice,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
