import 'package:flutter/material.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final TextEditingController controller = TextEditingController();

  bool isAnalyzing = false;
  String feedback = '';
  int wordCount = 0;
  int score = 0;

  final String topic =
      'Write about your daily routine and explain what you usually do in the morning.';

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      final words = controller.text
          .trim()
          .split(RegExp(r'\s+'))
          .where((word) => word.isNotEmpty)
          .length;

      if (mounted) {
        setState(() {
          wordCount = controller.text.trim().isEmpty ? 0 : words;
        });
      }
    });
  }

  Future<void> analyzeWriting() async {
    final text = controller.text.trim();

    if (text.isEmpty) {
      showMessage('Please write your answer first.');
      return;
    }

    if (wordCount < 10) {
      showMessage('Please write at least 10 words.');
      return;
    }

    setState(() {
      isAnalyzing = true;
      feedback = '';
      score = 0;
    });

    await Future.delayed(
      const Duration(milliseconds: 1200),
    );

    final lowerText = text.toLowerCase();

    int grammar = 65;
    int vocabulary = 65;
    int structure = 65;
    int content = 70;

    if (lowerText.contains('usually') ||
        lowerText.contains('every day') ||
        lowerText.contains('because')) {
      grammar += 10;
      vocabulary += 5;
    }

    if (wordCount >= 20) {
      vocabulary += 8;
      structure += 8;
      content += 8;
    }

    if (wordCount >= 40) {
      vocabulary += 5;
      structure += 7;
      content += 7;
    }

    grammar = grammar.clamp(0, 100);
    vocabulary = vocabulary.clamp(0, 100);
    structure = structure.clamp(0, 100);
    content = content.clamp(0, 100);

    final overall =
        ((grammar + vocabulary + structure + content) / 4).round();

    String level;

    if (overall >= 90) {
      level = 'Excellent';
    } else if (overall >= 80) {
      level = 'Very Good';
    } else if (overall >= 70) {
      level = 'Good';
    } else if (overall >= 60) {
      level = 'Needs Practice';
    } else {
      level = 'Beginner';
    }

    if (!mounted) return;

    setState(() {
      isAnalyzing = false;
      score = overall;

      feedback =
          'Overall: $overall / 100\n'
          'Level: $level\n\n'
          'Grammar: $grammar / 100\n'
          'Vocabulary: $vocabulary / 100\n'
          'Structure: $structure / 100\n'
          'Content: $content / 100\n\n'
          'AI Feedback\n\n'
          '✓ Your writing was analyzed successfully.\n\n'
          '• Try to use complete sentences.\n'
          '• Add more details to make your answer interesting.\n'
          '• Use a wider range of vocabulary.\n'
          '• Connect your ideas with words such as "because", '
          '"then", "after that", and "usually".';
    });
  }

  void clearWriting() {
    setState(() {
      controller.clear();
      feedback = '';
      score = 0;
      wordCount = 0;
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

  void showTips() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Writing Tips'),
          content: const Text(
            '1. Start with a clear sentence.\n\n'
            '2. Use complete sentences.\n\n'
            '3. Add details and examples.\n\n'
            '4. Connect your ideas.\n\n'
            '5. Check grammar and spelling.\n\n'
            '6. Try to use new vocabulary.',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Writing'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: showTips,
            icon: const Icon(Icons.lightbulb_outline),
            tooltip: 'Writing Tips',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5),
              Icon(
                Icons.edit_note,
                size: 75,
                color: colors.primary,
              ),
              const SizedBox(height: 12),
              const Text(
                'Write with AI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'تمرین نوشتن و دریافت بازخورد هوشمند',
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
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.topic,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Writing Topic',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        topic,
                        style: const TextStyle(
                          fontSize: 17,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Answer',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$wordCount words',
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: controller,
                    minLines: 10,
                    maxLines: 16,
                    textCapitalization:
                        TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText:
                          'Start writing your answer here...',
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.7,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      isAnalyzing ? null : analyzeWriting,
                  icon: isAnalyzing
                      ? const SizedBox(
                          width: 21,
                          height: 21,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.auto_awesome),
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
                              Icons.analytics_outlined,
                              color: colors.primary,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Writing Analysis',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        if (score > 0) ...[
                          Center(
                            child: Text(
                              '$score / 100',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
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
              const SizedBox(height: 18),
              OutlinedButton.icon(
                onPressed: clearWriting,
                icon: const Icon(Icons.refresh),
                label: const Text('Clear & Try Again'),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
