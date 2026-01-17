import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/ai_chat/data/chat_provider.dart';
import 'package:gear_head/features/ai_chat/data/message.dart';
import 'package:gear_head/features/ai_chat/presentation/chat_bubble.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AiChatSheet extends ConsumerStatefulWidget {
  final Map<String, dynamic> scenario;
  const AiChatSheet({super.key, required this.scenario});

  @override
  ConsumerState<AiChatSheet> createState() => _AiChatSheetState();
}

class _AiChatSheetState extends ConsumerState<AiChatSheet> {
  TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTss = FlutterTts();

  bool _isListening = false;
  bool _isMuted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.scenario["userQuery"];
    _initVoiceEngines();
  }

  void _initVoiceEngines() async {
    await _speechToText.initialize();
    await _flutterTss.setLanguage("en-US");
    await _flutterTss.setSpeechRate(0.45);
    setState(() {});
  }

  void _startListening() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speechToText.listen(onResult: (result) {
        setState(() {
          _controller.text = result.recognizedWords;
        });
      });
    }
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _speak(String text) async {
    if (!_isMuted) {
      await _flutterTss.speak(text);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(chatProvider);

    ref.listen(chatProvider, (previous, next) {
      next.whenData((messages) {
        if (messages.isNotEmpty && messages.last.type == MessageType.ai) {
          _speak(messages.last.text);
        }
      });
    });
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (_, controller) => ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: AppColors.surface.withOpacity(0.8),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.all(12),
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(2))),
                      _buildDiagnosticHeader(),
                      Expanded(
                          child: chatMessages.when(
                              data: (messages) {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => _scrollToBottom());
                                return ListView.builder(
                                    controller: controller,
                                    itemCount: messages.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    itemBuilder: (context, i) =>
                                        ChatBubble(message: messages[i]));
                              },
                              error: (e, __) => Center(
                                    child: Text("Error: $e"),
                                  ),
                              loading: () => Center(
                                    child: CircularProgressIndicator(),
                                  ))),
                      _buildInputArea(),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildDiagnosticHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            widget.scenario["carModel"].toUpperCase(),
            style:
                TextStyle(letterSpacing: 2, fontSize: 12, color: Colors.blue),
          ),
          Text(widget.scenario['title'],
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _chip(Icons.thermostat, "${widget.scenario["heat"]}C"),
              SizedBox(width: 8),
              _chip(Icons.oil_barrel, "${widget.scenario["oil"]}% OIL")
            ],
          )
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.blueAccent),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 10, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: _isListening
                      ? "GEARHEAD AI Listening..."
                      : "Tell me what's wrpng",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none)),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onLongPressStart: (_) => _startListening(),
            onLongPressEnd: (_) => _stopListening(),
            child: CircleAvatar(
              backgroundColor:
                  _isListening ? Colors.red : Colors.blue.withOpacity(0.2),
              child: Icon(_isListening ? Icons.mic : Icons.mic_none,
                  color: _isListening ? Colors.white : Colors.blue),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              ref
                  .read(chatProvider.notifier)
                  .sendMessage(_controller.text, widget.scenario);
              _controller.clear();
            },
            icon: const Icon(Icons.send, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
