import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/ai_chat/data/chat_provider.dart';
import 'package:gear_head/features/ai_chat/presentation/ai_chat_sheet.dart';
import 'package:gear_head/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gear_head/features/maintenance/presentation/history_screen.dart';
import 'package:gear_head/features/remote/presentation/remote_controll_screen.dart';
import 'package:gear_head/features/tracking/dummy/presentation/dummy_tracking_screen.dart';

import 'features/tracking/tracking_screen_main.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const RemoteControllScreen(),
    const DashboardScreen(),
    const TrackingScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.psychology_alt),
      //   onPressed: () async {
      //     final scenario =
      //         await ref.read(chatProvider.notifier).getRandomScenario();
      //     if (!mounted) return;
      //     showModalBottomSheet(
      //         context: context,
      //         isScrollControlled: true,
      //         backgroundColor: Colors.transparent,
      //         builder: (context) => AiChatSheet(scenario: scenario));
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primaryAccent,
          unselectedItemColor: Colors.white38,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.car_rental), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dash"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "History")
          ]),
    );
  }
}
