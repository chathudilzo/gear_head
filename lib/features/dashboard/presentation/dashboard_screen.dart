import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/dashboard/data/chart_notifier.dart';
import 'package:gear_head/features/dashboard/data/mock_obd_service.dart';
import 'package:gear_head/features/dashboard/presentation/widgets/gauge_painter.dart';
import 'package:gear_head/features/dashboard/presentation/widgets/performance_chart.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleData = ref.watch(vehcileStreamProvider);
    final rpmPoints = ref.watch(chartProvider('rpm'));

    return Scaffold(
      appBar: AppBar(
        title: Text("GEARHEAD TELEMETRY"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: vehicleData.when(
          data: (data) => SingleChildScrollView(
                child: Column(
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
                                  style:
                                      TextStyle(color: AppColors.textPrimary),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 180,
                        child: PerformanceChart(rpmPoints: rpmPoints)),
                    SizedBox(
                      height: 5,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     _buildStatCard("SPEED", "${data['speed']?.toInt()} km/h"),
                    //     _buildStatCard("ENGINE", "STABLE")
                    //   ],
                    // )

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1.1,
                        children: [
                          _buildMiniTile("SPEED",
                              '${(data['speed'] ?? 0).toInt()}', "km/h"),
                          _buildMiniTile(
                              "TEMP", "${(data['temp'] ?? 0).toInt()}", "C"),
                          _buildMiniTile(
                              "BATT",
                              "${(data["voltage"] ?? 12.6).toStringAsFixed(1)}",
                              "V"),
                          _buildMiniTile(
                              "LOAD", "${(data['load'] ?? 0).toInt()}", "%"),
                          _buildMiniTile(
                              "OIL", "${(data['oil'] ?? 0).toInt()}", "%"),
                          _buildMiniTile(
                              "FUEL", "${(data['fuel'] ?? 0).toInt()}", "%"),
                        ],
                      ),
                    ),
                    _buildStatusBar(data['status'])
                  ],
                ),
              ),
          error: (err, stack) => Center(
                child: Text("Error:$err"),
              ),
          loading: () => Center(
                child: CircularProgressIndicator(),
              )),
    );
  }

  Widget _buildStatusBar(String? status) {
    final isHealthy = status == "HEALTHY";

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: isHealthy
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          border: Border.all(color: isHealthy ? Colors.green : Colors.red)),
      child: Row(
        children: [
          Icon(
            isHealthy ? Icons.check_circle : Icons.warning,
            color: isHealthy ? Colors.green : Colors.green,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            isHealthy ? "SYSTEM HEALTHY" : "FAULT DETECTED:$status",
            style: TextStyle(
                color: isHealthy ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
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

  Widget _buildMiniTile(String label, String value, String unit,
      {Color? alertColor}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white)),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            unit,
            style: TextStyle(
                fontSize: 10, color: alertColor ?? AppColors.primaryAccent),
          )
        ],
      ),
    );
  }
}
