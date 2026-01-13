import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/dashboard/presentation/dashboard_screen.dart';
import 'package:gear_head/home_page.dart';

void main() {
  runApp(const ProviderScope(child: const GearheadApp()));
}

class GearheadApp extends StatelessWidget {
  const GearheadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: AppColors.background),
      home: const HomePage(),
    );
  }
}
