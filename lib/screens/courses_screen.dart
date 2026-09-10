import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  static const levels = [
    {
      'level': 'A1',
      'title': 'Beginner',
      'description': 'شروع زبان انگلیسی از پایه',
      'lessons': '40 درس',
    },
    {
      'level': 'A2',
      'title': 'Elementary',
      'description': 'ساختن پایه قوی در زبان',
      'lessons': '45 درس',
    },
    {
      'level': 'B1',
      'title': 'Intermediate',
      'description': 'مکالمه و درک مطلب متوسط',
      'lessons': '50 درس',
    },
    {
      'level': 'B2',
      'title': 'Upper Intermediate',
      'description': 'تقویت مکالمه و گرامر پیشرفته',
      'lessons': '55 درس',
    },
    {
      'level': 'C1',
      'title': 'Advanced',
      'description': 'انگلیسی پیشرفته و حرفه‌ای',
      'lessons': '60 درس',
    },
    {
      'level': 'C2',
      'title': 'Mastery',
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
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final course = levels[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 14),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'دوره ${course['level']} انتخاب شد',
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(
                        course['level']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(course['description']!),
                          const SizedBox(height: 7),
                          Text(
                            course['lessons']!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 18),
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
