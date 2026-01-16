import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/core/theme/app_colors.dart';
import 'package:gear_head/features/maintenance/data/alert_notifier.dart';
import 'package:gear_head/features/tracking/google_tracking/data/google_tacking_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as ll;

class GoogleTrackingScreen extends ConsumerWidget {
  const GoogleTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(alertLoggerProvider);
    final vehicleState = ref.watch(vehcileTrackingProvider);
    final centerPoint = LatLng(6.7056, 80.3847);

    return Scaffold(
      appBar: AppBar(
        title: Text("G-MAPS TRACKER"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: centerPoint, zoom: 15),
            myLocationButtonEnabled: false,
            circles: mySafeZones.map((zone) {
              return Circle(
                  circleId: CircleId(zone.id),
                  center: zone.center,
                  radius: zone.radius,
                  fillColor: vehicleState.isSafe
                      ? AppColors.primaryAccent.withOpacity(0.1)
                      : AppColors.danger.withOpacity(0.2),
                  strokeColor: vehicleState.isSafe
                      ? AppColors.primaryAccent
                      : AppColors.danger,
                  strokeWidth: 2);
            }).toSet(),
            polylines: {
              Polyline(
                  polylineId: PolylineId("trip_trail"),
                  points: vehicleState.breadcrumbs,
                  color: AppColors.primaryAccent,
                  width: 4,
                  jointType: JointType.round,
                  startCap: Cap.roundCap,
                  endCap: Cap.roundCap)
            },
            markers: {
              Marker(
                  markerId: MarkerId("Car_1"),
                  position: vehicleState.position,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      vehicleState.isSafe
                          ? BitmapDescriptor.hueGreen
                          : BitmapDescriptor.hueRed),
                  infoWindow: InfoWindow(
                      title: vehicleState.isSafe
                          ? "Safe"
                          : "WARNING:PUTSIDE ZONE"))
            },
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Card(
              color: vehicleState.isSafe ? AppColors.surface : AppColors.danger,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                        vehicleState.isSafe
                            ? Icons.check_circle
                            : Icons.warning,
                        color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      vehicleState.isSafe
                          ? "Vehicle Secure"
                          : "GEOFENCE BREACH DETECTED",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
