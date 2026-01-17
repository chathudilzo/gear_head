import 'dart:convert';
import 'dart:math';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/features/ai_chat/data/message.dart';

final chatProvider =
    AsyncNotifierProvider<ChatNotifier, List<ChatMessage>>(ChatNotifier.new);

class ChatNotifier extends AsyncNotifier<List<ChatMessage>> {
  @override
  Future<List<ChatMessage>> build() async => [];

  Future<Map<String, dynamic>> getRandomScenario() async {
    final String response =
        await rootBundle.loadString("assets/data/scenarios.json");
    final data = json.decode(response);
    final List scenarios = data['scenarios'];
    return scenarios[Random().nextInt(scenarios.length)];
  }

  Future<void> sendMessage(
      String userText, Map<String, dynamic> scenario) async {
    final currentMessages = state.value ?? [];

    state = AsyncData([
      ...currentMessages,
      ChatMessage(text: userText, type: MessageType.user)
    ]);
    state = const AsyncLoading<List<ChatMessage>>().copyWithPrevious(state);

    try {
      final model =
          FirebaseAI.googleAI().generativeModel(model: "gemini-2.5-flash-lite");
      final prompt = """
        [VEHICLE DATA]
        Model: ${scenario['carModel']}
        Status: ${scenario['title']}
        Fault Code: ${scenario['faultCode']}
        
        [LIVE SENSORS]
        Engine Temp: ${scenario['heat']}°C
        Oil Life: ${scenario['oil']}%
        Fuel Level: ${scenario['fuel']}%

        [USER QUESTION]
        "$userText"

        INSTRUCTION: Act as a Car specialist. 
        Analyze if the ${scenario['heat']}°C temperature is critical for a ${scenario['carModel']}.
        Provide localized safety advice for Sri Lanka.
      """;

      final response = await model.generateContent([Content.text(prompt)]);
      print(response);
      final aiText = response.text ?? "ECU data anysis failed";
      state = AsyncData(
          [...state.value!, ChatMessage(text: aiText, type: MessageType.ai)]);
    } catch (error) {
      print(error);
      state = AsyncError(error, StackTrace.current);
    }
  }
}
