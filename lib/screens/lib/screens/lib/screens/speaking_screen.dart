import 'package:flutter/material.dart';

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  bool isRecording = false;
  String result = '';

  void toggleRecording() {
    setState(() {
      isRecording = !isRecording;

      if (!isRecording) {
        result =
            'Your speaking will be analyzed here.\n\n'
            'Pronunciation: --\n'
            'Grammar: --\n'
            'Fluency: --\n'
            'Overall Score: --';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Speaking'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.record_voice_over,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              'Speak with AI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Speak naturally and receive AI feedback.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Speaking Challenge',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Tell me about your daily routine.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            Center(
              child: GestureDetector(
                onTap: toggleRecording,
                child: CircleAvatar(
                  radius: 55,
                  child: Icon(
                    isRecording ? Icons.stop : Icons.mic,
                    size: 50,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              isRecording
                  ? 'Recording... Tap to stop'
                  : 'Tap the microphone to start',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            if (result.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.7,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Analyze with AI'),
            ),
          ],
        ),
      ),
    );
  }
}
