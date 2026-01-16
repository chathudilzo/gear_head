import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:latlong2/latlong.dart';
import 'dart:math' as math;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleState {
  final LatLng position;
  final bool isSafe;
  final List<LatLng> breadcrumbs;
  VehicleState(
      {required this.position,
      required this.isSafe,
      required this.breadcrumbs});
}

class GeofenceConfig {
  final String id;
  final String name;
  final LatLng center;
  final double radius;

  GeofenceConfig({
    required this.id,
    required this.name,
    required this.center,
    this.radius = 400.0,
  });
}

final List<GeofenceConfig> mySafeZones = [
  GeofenceConfig(
      id: "home",
      name: "Home - Ratnapura",
      center: const LatLng(6.7056, 80.3847)),
  GeofenceConfig(
      id: "office",
      name: "Office -Rathnapura",
      center: const LatLng(6.7300, 80.3900)),
  GeofenceConfig(
      id: "garage",
      name: "Service Center",
      center: const LatLng(6.7150, 80.4000)),
];

class VehicleTrackingNotifier extends Notifier<VehicleState> {
  final List<LatLng> _routeWaypoints = [
    const LatLng(6.7050, 80.3840),
    const LatLng(6.7065, 80.3865),
    const LatLng(6.7080, 80.3890),
    const LatLng(6.7100, 80.3920),
    LatLng(6.7150, 80.4000),
    LatLng(6.7300, 80.3900),
    const LatLng(6.7080, 80.3890),
    const LatLng(6.7056, 80.3847),
  ];
  final LatLng _centerPoint = const LatLng(6.7056, 80.3847);
  final double _safeRadius = 400.0;
  int _currentStepIndex = 0;

  final List<LatLng> _safeCenters = [
    const LatLng(6.7056, 80.3847),
    const LatLng(6.7150, 80.4000),
  ];

  Timer? _timer;
  List<LatLng> _interpolatedPath = [];

  @override
  VehicleState build() {
    _generateSmoothPath(stepsPerSegment: 5);
    _startSimulation();
    ref.onDispose(() => _timer?.cancel());
    return VehicleState(
        position: _interpolatedPath[0],
        isSafe: true,
        breadcrumbs: [_interpolatedPath[0]]);
  }

  void _generateSmoothPath({required int stepsPerSegment}) {
    _interpolatedPath.clear();

    for (int i = 0; i < _routeWaypoints.length - 1; i++) {
      LatLng start = _routeWaypoints[i];
      LatLng end = _routeWaypoints[i + 1];
      for (int step = 0; step <= stepsPerSegment; step++) {
        double t = step / stepsPerSegment;
        double lat = start.latitude + (end.latitude - start.latitude) * t;
        double lng = start.longitude + (end.longitude - start.longitude) * t;
        _interpolatedPath.add(LatLng(lat, lng));
      }
    }
  }

  void _startSimulation() {
    double angle = 0;
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // angle += 0.2;
      // final orbitiAnchorLng = _centerPoint.longitude + 0.0035;
      // final newLat = _centerPoint.latitude + (0.004 * math.sin(angle));
      // final newLng = orbitiAnchorLng + (0.004 * math.cos(angle));
      // final newPos = LatLng(newLat, newLng);

      _currentStepIndex = (_currentStepIndex + 1) % _interpolatedPath.length;
      final newPos = _interpolatedPath[_currentStepIndex];

      bool currentlySafe = false;

      for (var center in _safeCenters) {
        if (_calculateDistance(center, newPos) <= _safeRadius) {
          currentlySafe = true;
          break;
        }
      }

      state = VehicleState(
          position: newPos,
          isSafe: currentlySafe,
          breadcrumbs: [...state.breadcrumbs, newPos]);
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
