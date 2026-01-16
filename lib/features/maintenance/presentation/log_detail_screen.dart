import 'package:flutter/material.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/maintenance/data/database/database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LogDetailsScreen extends StatelessWidget {
  final AlertLog log;

  const LogDetailsScreen({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    final position = LatLng(log.latitude ?? 6.7056, log.longitude ?? 80.3847);
    return Scaffold(
      appBar: AppBar(
        title: Text(log.type),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: position, zoom: 16),
              liteModeEnabled: true,
              markers: {
                Marker(
                    markerId: MarkerId("incident_loc"),
                    position: position,
                    infoWindow: InfoWindow(title: "Incident Location"))
              },
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(20),
            color: AppColors.background,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Timestamp", "${log.timestamp}"),
                _buildDetailRow(
                    "Coordinates", "${log.latitude}, ${log.longitude}"),
                const Divider(color: Colors.white24, height: 30),
                const Text("MESSAGE",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 10),
                Text(
                  log.message,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
