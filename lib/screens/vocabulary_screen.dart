import 'package:flutter/material.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  int currentWord = 0;

  final words = [
    {
      'word': 'Beautiful',
      'meaning': 'زیبا',
      'example': 'She has a beautiful voice.',
      'level': 'A1',
    },
    {
      'word': 'Improve',
      'meaning': 'بهبود دادن',
      'example': 'I want to improve my English.',
      'level': 'A2',
    },
    {
      'word': 'Opportunity',
      'meaning': 'فرصت',
      'example': 'This is a great opportunity.',
      'level': 'B1',
    },
    {
      'word': 'Accurate',
      'meaning': 'دقیق',
      'example': 'Please give me an accurate answer.',
      'level': 'B2',
    },
    {
      'word': 'Significant',
      'meaning': 'قابل توجه / مهم',
      'example': 'There was a significant improvement.',
      'level': 'C1',
    },
    {
      'word': 'Ambiguous',
      'meaning': 'مبهم',
      'example': 'The sentence is ambiguous.',
      'level': 'C2',
    },
  ];

  void nextWord() {
    setState(() {
      currentWord = (currentWord + 1) % words.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final word = words[currentWord];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.translate,
              size: 70,
            ),

            const SizedBox(height: 20),

            Text(
              'Word ${currentWord + 1} / ${words.length}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      word['level']!,
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      word['word']!,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      word['meaning']!,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),

                    const Divider(height: 35),

                    Text(
                      word['example']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: nextWord,
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Next Word',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
