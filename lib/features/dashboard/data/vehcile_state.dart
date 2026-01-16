import 'package:latlong2/latlong.dart';

class VehicleState {
  final LatLng position;
  final bool isSafe;
  final double fuelLevel;
  final double oilLife;
  final double coolantHealth;
  final double cumulativeWear;

  VehicleState(
      {required this.position,
      required this.isSafe,
      required this.fuelLevel,
      required this.oilLife,
      required this.coolantHealth,
      required this.cumulativeWear});
}
