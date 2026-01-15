import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/tracking/dummy/presentation/dummy_tracking_screen.dart';
import 'package:gear_head/features/tracking/google_tracking/presentation/google_tracking_screen.dart';
import 'package:gear_head/features/tracking/tracking_toggle_provider.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(trackingTypeProvider);

    const List<Widget> pages = [DummyTrackingScreen(), GoogleTrackingScreen()];

    return Scaffold(
      body: Stack(
        children: [
          pages[currentIndex],
          Positioned(
              top: 100,
              right: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    _toggleButton(ref, "Simulated", 0, currentIndex == 0),
                    _toggleButton(ref, "Live G-Maps", 1, currentIndex == 1)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _toggleButton(WidgetRef ref, String label, int index, bool isActive) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () => ref.read(trackingTypeProvider.notifier).state = index,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: isActive ? AppColors.primaryAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(label,
                style: TextStyle(
                    color: isActive ? Colors.black : Colors.white60,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
