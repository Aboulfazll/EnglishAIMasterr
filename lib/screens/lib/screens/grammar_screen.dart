import 'package:flutter/material.dart';

import 'screens/courses_screen.dart';
import 'screens/listening_screen.dart';
import 'screens/speaking_screen.dart';
import 'screens/teacher_screen.dart';
import 'screens/placement_test_screen.dart';
import 'screens/vocabulary_screen.dart';
import 'screens/grammar_screen.dart';

void main() {
  runApp(const EnglishAIMasterApp());
}

class EnglishAIMasterApp extends StatelessWidget {
  const EnglishAIMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English AI Master',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English AI Master'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              const Icon(
                Icons.auto_awesome,
                size: 70,
              ),

              const SizedBox(height: 12),

              const Text(
                'English AI Master',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'یادگیری انگلیسی با هوش مصنوعی',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 30),

              _MenuCard(
                icon: Icons.headphones,
                title: 'AI Listening',
                subtitle: 'تقویت مهارت شنیداری',
                onTap: () {
                  openPage(
                    context,
                    const ListeningScreen(),
                  );
                },
              ),

              _MenuCard(
                icon: Icons.mic,
                title: 'AI Speaking',
                subtitle: 'تمرین مکالمه و تلفظ',
                onTap: () {
                  openPage(
                    context,
                    const SpeakingScreen(),
                  );
                },
              ),

              _MenuCard(
                icon: Icons.smart_toy,
                title: 'AI Teacher',
                subtitle: 'مکالمه با معلم هوش مصنوعی',
                onTap: () {
                  openPage(
                    context,
                    const TeacherScreen(),
                  );
                },
              ),

              _MenuCard(
                icon: Icons.menu_book,
                title: 'Courses',
                subtitle: 'دوره‌های A1 تا C2',
                onTap: () {
                  openPage(
                    context,
                    const CoursesScreen(),
                  );
                },
              ),

              _MenuCard(
                icon: Icons.assignment,
                title: 'Placement Test',
                subtitle: 'تعیین سطح زبان',
                onTap: () {
                  openPage(
                    context,
                    const PlacementTestScreen(),
                  );
                },
              ),

              _MenuCard(
                icon: Icons.translate,
                title: 'Vocabulary',
                subtitle: 'یادگیری لغات A1 تا C2',
                onTap: () {
                  openPage(
                    context,
                    const VocabularyScreen(),
                  );
                },
              ),

              _MenuCard(
                icon: Icons.school,
                title: 'Grammar',
                subtitle: 'گرامر انگلیسی A1 تا C2',
                onTap: () {
                  openPage(
                    context,
                    const GrammarScreen(),
                  );
                },
              ),

              const SizedBox(height: 15),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        size: 40,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Daily Goal',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'امروز 0 از 20 دقیقه',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
        onTap: onTap,
      ),
    );
  }
}
