import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  static const List<Map<String, String>> courses = [
    {
      'level': 'A1',
      'title': 'Beginner',
      'persian': 'مبتدی',
      'description': 'شروع زبان انگلیسی از پایه',
      'lessons': '40 درس',
    },
    {
      'level': 'A2',
      'title': 'Elementary',
      'persian': 'مقدماتی',
      'description': 'ساختن پایه قوی در زبان انگلیسی',
      'lessons': '45 درس',
    },
    {
      'level': 'B1',
      'title': 'Intermediate',
      'persian': 'متوسط',
      'description': 'تقویت مکالمه و درک مطلب',
      'lessons': '50 درس',
    },
    {
      'level': 'B2',
      'title': 'Upper Intermediate',
      'persian': 'متوسط رو به بالا',
      'description': 'تقویت گرامر و مکالمه پیشرفته',
      'lessons': '55 درس',
    },
    {
      'level': 'C1',
      'title': 'Advanced',
      'persian': 'پیشرفته',
      'description': 'انگلیسی پیشرفته و حرفه‌ای',
      'lessons': '60 درس',
    },
    {
      'level': 'C2',
      'title': 'Mastery',
      'persian': 'تسلط کامل',
      'description': 'تسلط بسیار بالا بر زبان انگلیسی',
      'lessons': '60 درس',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetailScreen(
                      course: course,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      child: Text(
                        course['level']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['title']!,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            course['persian']!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            course['description']!,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            course['lessons']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final Map<String, String> course;

  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${course['level']} Course'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 45,
              child: Text(
                course['level']!,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              course['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              course['persian']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Course Skills',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _SkillRow(
                      icon: Icons.menu_book,
                      title: 'Grammar',
                      subtitle: 'گرامر سطح ${course['level']}',
                    ),
                    _SkillRow(
                      icon: Icons.translate,
                      title: 'Vocabulary',
                      subtitle: 'لغات کاربردی',
                    ),
                    _SkillRow(
                      icon: Icons.headphones,
                      title: 'Listening',
                      subtitle: 'تمرین شنیداری',
                    ),
                    _SkillRow(
                      icon: Icons.record_voice_over,
                      title: 'Speaking',
                      subtitle: 'تمرین مکالمه',
                    ),
                    _SkillRow(
                      icon: Icons.chrome_reader_mode,
                      title: 'Reading',
                      subtitle: 'درک مطلب',
                    ),
                    _SkillRow(
                      icon: Icons.edit,
                      title: 'Writing',
                      subtitle: 'تمرین نوشتاری',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Course started successfully!',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  'Start Course',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SkillRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            child: Icon(
              icon,
              size: 21,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
