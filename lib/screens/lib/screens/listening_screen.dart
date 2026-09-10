import 'package:flutter/material.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  bool isPlaying = false;
  double speed = 1.0;

  final String transcript =
      'Hello! My name is Alex. I am learning English every day. '
      'I usually listen to English conversations and practice speaking.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Listening'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.headphones,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              'Daily Listening',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Listen carefully and understand the conversation.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'AI Conversation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    IconButton(
                      iconSize: 70,
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle
                            : Icons.play_circle,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      isPlaying ? 'Playing...' : 'Press Play',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
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
                fontSize: 18,
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
              'Speed: ${speed.toStringAsFixed(1)}x',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            const Text(
              'Transcript',
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
                  transcript,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.quiz),
              label: const Text(
                'Comprehension Questions',
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.refresh),
              label: const Text(
                'New AI Conversation',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
