import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override 
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final TextEditingController messageController =
      TextEditingController();

  final ScrollController scrollController = ScrollController();

  final FlutterTts tts = FlutterTts();

  final List<_ChatMessage> messages = [
    _ChatMessage(
      text:
          'Hello! I am your AI English Teacher. What would you like to practice today?',
      isUser: false,
    ),
  ];

  bool isTyping = false;
  bool isSpeaking = false;

  final List<String> suggestions = [
    'Let’s practice speaking',
    'Correct my grammar',
    'Teach me new words',
    'Start a roleplay',
  ];

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  Future<void> initializeTts() async {
    await tts.setLanguage('en-US');
    await tts.setSpeechRate(0.45);
    await tts.setPitch(1.0);

    tts.setStartHandler(() {
      if (!mounted) return;

      setState(() {
        isSpeaking = true;
      });
    });

    tts.setCompletionHandler(() {
      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });
    });

    tts.setCancelHandler(() {
      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future<void> speakMessage(String text) async {
    if (isSpeaking) {
      await tts.stop();

      if (!mounted) return;

      setState(() {
        isSpeaking = false;
      });

      return;
    }

    await tts.speak(text);
  }

  Future<void> sendMessage([String? predefinedMessage]) async {
    final text =
        (predefinedMessage ?? messageController.text).trim();

    if (text.isEmpty || isTyping) {
      return;
    }

    messageController.clear();

    setState(() {
      messages.add(
        _ChatMessage(
          text: text,
          isUser: true,
        ),
      );

      isTyping = true;
    });

    scrollToBottom();

    await Future.delayed(
      const Duration(milliseconds: 900),
    );

    final response = generateTeacherResponse(text);

    if (!mounted) return;

    setState(() {
      messages.add(
        _ChatMessage(
          text: response,
          isUser: false,
        ),
      );

      isTyping = false;
    });

    scrollToBottom();
  }

  String generateTeacherResponse(String input) {
    final text = input.toLowerCase();

    if (text.contains('hello') ||
        text.contains('hi') ||
        text.contains('hey')) {
      return 'Hello! 👋 Nice to meet you. Let’s practice English together. Tell me something about yourself.';
    }

    if (text.contains('grammar') ||
        text.contains('correct')) {
      return 'Of course! Send me an English sentence and I will help you correct it and explain the grammar.';
    }

    if (text.contains('vocabulary') ||
        text.contains('word')) {
      return 'Great choice! Try learning these words today: confident, improve, communicate, opportunity, and experience.';
    }

    if (text.contains('roleplay')) {
      return 'Great! Let’s do a roleplay. Imagine we are at a hotel. You are the guest and I am the receptionist. Start by checking in.';
    }

    if (text.contains('practice') ||
        text.contains('speaking')) {
      return 'Excellent! Let’s practice speaking. Answer this question in English: What do you usually do after work or school?';
    }

    if (text.contains('thank')) {
      return 'You’re welcome! 😊 Keep practicing every day. Consistency is the key to improving your English.';
    }

    if (text.endsWith('?')) {
      return 'That’s a good question! Try answering it in English first. I can then correct your grammar and help you make your answer more natural.';
    }

    return 'Good job! 👍 Let’s make your English even better. Try to give me a longer answer using complete sentences. I can help you with grammar, vocabulary, pronunciation, and fluency.';
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void clearConversation() {
    setState(() {
      messages.clear();

      messages.add(
        const _ChatMessage(
          text:
              'Hello! I am your AI English Teacher. What would you like to practice today?',
          isUser: false,
        ),
      );
    });

    scrollToBottom();
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Teacher'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Clear conversation',
            onPressed: clearConversation,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildTeacherHeader(colors),
            _buildSuggestions(),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  16,
                ),
                itemCount: messages.length + (isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= messages.length) {
                    return const _TypingBubble();
                  }

                  return _buildMessage(
                    messages[index],
                    colors,
                  );
                },
              ),
            ),
            _buildInputArea(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherHeader(ColorScheme colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        14,
        18,
        14,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: colors.primaryContainer,
                child: Icon(
                  Icons.psychology,
                  size: 30,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your AI English Teacher',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 9,
                          color: Colors.green,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Online • Ready to help',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ActionChip(
            label: Text(suggestions[index]),
            onPressed: () {
              sendMessage(suggestions[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildMessage(
    _ChatMessage message,
    ColorScheme colors,
  ) {
    final alignment = message.isUser
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    final bubbleColor = message.isUser
        ? colors.primaryContainer
        : colors.surfaceContainerHighest;

    final textColor = message.isUser
        ? colors.onPrimaryContainer
        : colors.onSurface;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          mainAxisAlignment: message.isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!message.isUser) ...[
              CircleAvatar(
                radius: 17,
                backgroundColor: colors.primaryContainer,
                child: Icon(
                  Icons.smart_toy,
                  size: 19,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(
                  bottom: 8,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                    color: textColor,
                  ),
                ),
              ),
            ),
            if (message.isUser) ...[
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 17,
                backgroundColor: colors.secondaryContainer,
                child: Icon(
                  Icons.person,
                  size: 19,
                  color: colors.onSecondaryContainer,
                ),
              ),
            ],
          ],
        ),
        if (!message.isUser)
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              tooltip: 'Listen',
              visualDensity: VisualDensity.compact,
              onPressed: () {
                speakMessage(message.text);
              },
              icon: Icon(
                isSpeaking
                    ? Icons.stop_circle_outlined
                    : Icons.volume_up_outlined,
                size: 21,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInputArea(ColorScheme colors) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        12,
        8,
        12,
        12,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(
            color: colors.outlineVariant,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              onSubmitted: (_) {
                sendMessage();
              },
              decoration: InputDecoration(
                hintText: 'Type your English message...',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            heroTag: 'teacher_send',
            mini: true,
            onPressed: isTyping
                ? null
                : () {
                    sendMessage();
                  },
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  const _ChatMessage({
    required this.text,
    required this.isUser,
  });
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          left: 42,
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 7,
              height: 7,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'AI Teacher is typing...',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
