import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/dashboard/data/mock_obd_service.dart';
import 'package:gear_head/features/dashboard/presentation/widgets/gauge_painter.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleData = ref.watch(vehcileStreamProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("GEARHEAD TELEMETRY"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: vehicleData.when(
          data: (data) => Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 280,
                      height: 280,
                      child: CustomPaint(
                        painter: GaugePainter(
                            value: data['rpm'] ?? 0, max: 8000, label: "RPM"),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                (data['rpm']?.toInt()).toString(),
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryAccent),
                              ),
                              Text(
                                "RPM",
                                style: TextStyle(color: AppColors.textPrimary),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard("SPEED", "${data['speed']?.toInt()} km/h"),
                      _buildStatCard("ENGINE", "STABLE")
                    ],
                  )
                ],
              ),
          error: (err, stack) => Center(
                child: Text("Error:$err"),
              ),
          loading: () => Center(
                child: CircularProgressIndicator(),
              )),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.surface, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
