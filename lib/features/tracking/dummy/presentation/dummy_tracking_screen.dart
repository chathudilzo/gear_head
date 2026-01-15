import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/tracking/dummy/data/tracking_provider.dart';
import 'package:latlong2/latlong.dart';

class DummyTrackingScreen extends ConsumerWidget {
  const DummyTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclePos = ref.watch(vehicleLocationProvider);
    final isSafe = ref.watch(geofenceStatusProvider);

    const centerPoint = LatLng(51.5074, -0.1278);
    return Scaffold(
      appBar: AppBar(
        title: const Text("VEHICLE TRACKER"),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FlutterMap(
              options:
                  const MapOptions(initialCenter: centerPoint, initialZoom: 15),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.gearhead.app',
                ),
                CircleLayer(circles: [
                  CircleMarker(
                      point: centerPoint,
                      radius: 200,
                      useRadiusInMeter: true,
                      color: isSafe
                          ? AppColors.primaryAccent.withOpacity(0.1)
                          : AppColors.danger.withOpacity(0.2),
                      borderColor:
                          isSafe ? AppColors.primaryAccent : AppColors.danger,
                      borderStrokeWidth: 2),
                ]),
                MarkerLayer(markers: [
                  Marker(
                      point: vehiclePos,
                      width: 60,
                      height: 60,
                      child: Icon(
                        Icons.navigation,
                        color:
                            isSafe ? AppColors.primaryAccent : AppColors.danger,
                        size: 40,
                      ))
                ])
              ]),
          if (!isSafe)
            Positioned(
                child: _GeofenceAlertCard(), bottom: 30, left: 20, right: 20)
        ],
      ),
    );
  }
}

class _GeofenceAlertCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
            size: 28,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Text(
            "GEOFENCE BREACH!\nVehicle has left the safe zone.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
