import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:latlong2/latlong.dart';
import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleState {
  final LatLng position;
  final bool isSafe;
  VehicleState({required this.position, required this.isSafe});
}

class VehicleTrackingNotifier extends Notifier<VehicleState> {
  final LatLng _centerPoint = const LatLng(6.7056, 80.3847);
  final double _safeRadius = 300.0;

  Timer? _timer;

  @override
  VehicleState build() {
    _startSimulation();
    ref.onDispose(() => _timer?.cancel());
    return VehicleState(position: _centerPoint, isSafe: true);
  }

  void _startSimulation() {
    double angle = 0;
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      angle += 0.2;
      final orbitiAnchorLng = _centerPoint.longitude + 0.0035;
      final newLat = _centerPoint.latitude + (0.004 * math.sin(angle));
      final newLng = orbitiAnchorLng + (0.004 * math.cos(angle));
      final newPos = LatLng(newLat, newLng);

      state = VehicleState(
          position: newPos,
          isSafe: _calculateDistance(_centerPoint, newPos) <= _safeRadius);
    });
  }

  double _calculateDistance(LatLng p1, LatLng p2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        math.cos((p2.latitude - p1.latitude) * p) / 2 +
        math.cos(p1.latitude * p) *
            math.cos(p2.latitude * p) *
            (1 - math.cos((p2.longitude - p1.longitude) * p)) /
            2;
    return 12742000 * math.asin(math.sqrt(a));
  }
}

final vehcileTrackingProvider =
    NotifierProvider<VehicleTrackingNotifier, VehicleState>(() {
  return VehicleTrackingNotifier();
});
