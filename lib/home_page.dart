import 'package:flutter/material.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gear_head/features/maintenance/presentation/history_screen.dart';
import 'package:gear_head/features/tracking/dummy/presentation/dummy_tracking_screen.dart';

import 'features/tracking/tracking_screen_main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TrackingScreen(),
    const HistoryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primaryAccent,
          unselectedItemColor: Colors.white38,
          onTap: (index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dash"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "History")
          ]),
    );
  }
}
