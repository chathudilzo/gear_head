import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/maintenance/data/database/database.dart';
import 'package:gear_head/features/maintenance/presentation/log_detail_screen.dart';
import 'package:gear_head/main.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsyncValue = ref.watch(alertStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("INCIDENT LOGS"),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: logsAsyncValue.when(
          data: (logs) {
            if (logs.isEmpty) {
              return const Center(
                  child: Text("No incidents recorded.Drive safe!"));
            }
            return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return AlertCard(log: log);
                });
          },
          error: (err, stack) => Center(
                child: Text("Error loading history: $err"),
              ),
          loading: () => Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}

class AlertCard extends StatelessWidget {
  final AlertLog log;

  const AlertCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LogDetailsScreen(log: log)));
        },
        contentPadding: EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppColors.danger,
          child: Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          log.type,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 4,
            ),
            Text(
              log.message,
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${log.timestamp.day}/${log.timestamp.month} ${log.timestamp.hour} : ${log.timestamp.minute}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  "Lat: ${log.latitude?.toStringAsFixed(4)} Lng: ${log.longitude?.toStringAsFixed(4)}",
                  style:
                      TextStyle(fontSize: 10, color: AppColors.primaryAccent),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
