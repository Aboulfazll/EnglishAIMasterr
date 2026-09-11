import 'package:flutter/material.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() =>
      _VocabularyScreenState();
}

class _VocabularyScreenState
    extends State<VocabularyScreen> {
  int currentIndex = 0;
  int learnedWords = 0;
  bool showMeaning = false;

  final List<_VocabularyWord> words = [
    _VocabularyWord(
      word: 'Improve',
      pronunciation: '/ɪmˈpruːv/',
      meaning: 'بهبود دادن، بهتر شدن',
      example: 'I want to improve my English.',
      level: 'A2',
    ),
    _VocabularyWord(
      word: 'Confident',
      pronunciation: '/ˈkɒnfɪdənt/',
      meaning: 'با اعتماد به نفس',
      example: 'She feels confident when speaking English.',
      level: 'B1',
    ),
    _VocabularyWord(
      word: 'Opportunity',
      pronunciation: '/ˌɒpəˈtjuːnəti/',
      meaning: 'فرصت',
      example: 'This job is a great opportunity.',
      level: 'B1',
    ),
    _VocabularyWord(
      word: 'Reliable',
      pronunciation: '/rɪˈlaɪəbəl/',
      meaning: 'قابل اعتماد',
      example: 'He is a reliable person.',
      level: 'B2',
    ),
    _VocabularyWord(
      word: 'Achievement',
      pronunciation: '/əˈtʃiːvmənt/',
      meaning: 'دستاورد، موفقیت',
      example: 'Passing the exam was a great achievement.',
      level: 'B2',
    ),
    _VocabularyWord(
      word: 'Perspective',
      pronunciation: '/pəˈspektɪv/',
      meaning: 'دیدگاه، نگرش',
      example: 'Travel can change your perspective.',
      level: 'C1',
    ),
    _VocabularyWord(
      word: 'Compelling',
      pronunciation: '/kəmˈpelɪŋ/',
      meaning: 'قانع‌کننده، بسیار جذاب',
      example: 'She gave a compelling argument.',
      level: 'C1',
    ),
    _VocabularyWord(
      word: 'Inevitable',
      pronunciation: '/ɪnˈevɪtəbəl/',
      meaning: 'اجتناب‌ناپذیر',
      example: 'Change is inevitable.',
      level: 'C2',
    ),
  ];

  _VocabularyWord get currentWord =>
      words[currentIndex];

  void toggleMeaning() {
    setState(() {
      showMeaning = !showMeaning;
    });
  }

  void markAsLearned() {
    if (learnedWords < words.length) {
      learnedWords++;
    }

    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++;
        showMeaning = false;
      });
    } else {
      setState(() {
        showMeaning = true;
      });
    }
  }

  void previousWord() {
    if (currentIndex == 0) return;

    setState(() {
      currentIndex--;
      showMeaning = false;
    });
  }

  void resetWords() {
    setState(() {
      currentIndex = 0;
      learnedWords = 0;
      showMeaning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: resetWords,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              _buildHeader(colors),
              const SizedBox(height: 22),
              _buildProgress(colors),
              const SizedBox(height: 25),
              _buildWordCard(colors),
              const SizedBox(height: 20),
              _buildNavigation(),
              const SizedBox(height: 28),
              _buildDailyTips(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colors) {
    return Column(
      children: [
        Icon(
          Icons.menu_book_rounded,
          size: 65,
          color: colors.primary,
        ),
        const SizedBox(height: 12),
        const Text(
          'Build Your Vocabulary',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Learn useful English words every day.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildProgress(ColorScheme colors) {
    final progress =
        (currentIndex + 1) / words.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up),
                const SizedBox(width: 9),
                const Expanded(
                  child: Text(
                    'Learning Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '$learnedWords learned',
                  style: TextStyle(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius:
                  BorderRadius.circular(10),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Word ${currentIndex + 1} of ${words.length}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordCard(ColorScheme colors) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          22,
          25,
          22,
          25,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(
                  currentWord.level,
                  style: TextStyle(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              currentWord.word,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              currentWord.pronunciation,
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 25),
            if (!showMeaning)
              OutlinedButton.icon(
                onPressed: toggleMeaning,
                icon: const Icon(
                  Icons.visibility_outlined,
                ),
                label: const Text(
                  'Show Meaning',
                ),
              )
            else ...[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Meaning',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      currentWord.meaning,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Example',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      currentWord.example,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNavigation() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed:
                currentIndex > 0 ? previousWord : null,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Previous'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                showMeaning ? markAsLearned : null,
            icon: Icon(
              currentIndex == words.length - 1
                  ? Icons.check
                  : Icons.arrow_forward,
            ),
            label: Text(
              currentIndex == words.length - 1
                  ? 'Finish'
                  : 'Learned',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyTips(ColorScheme colors) {
    return Card(
      color: colors.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: colors.onSecondaryContainer,
                ),
                const SizedBox(width: 9),
                Text(
                  'Vocabulary Tip',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color:
                        colors.onSecondaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Try to use each new word in your own sentence. '
              'Using a word actively helps you remember it for longer.',
              style: TextStyle(
                height: 1.55,
                color: colors.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VocabularyWord {
  final String word;
  final String pronunciation;
  final String meaning;
  final String example;
  final String level;

  const _VocabularyWord({
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.example,
    required this.level,
  });
}
