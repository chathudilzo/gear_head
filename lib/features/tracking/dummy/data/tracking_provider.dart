import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class VehicleLocationNotifier extends Notifier<LatLng> {
  final List<LatLng> _path = [
    LatLng(51.5074, -0.1278), // Center (Safe)
    LatLng(51.5080, -0.1285), // Moving away
    LatLng(51.5095, -0.1300), // Outside (250m+)
    LatLng(51.5110, -0.1320), // Far away
    LatLng(51.5085, -0.1260), // Coming back
  ];

  int _index = 0;

  LatLng build() {
    final timer = Timer.periodic(Duration(seconds: 3), (t) {
      _index = (_index + 1) % _path.length;
      state = _path[_index];
    });
    ref.onDispose(() => timer.cancel());

    return _path[0];
  }
}

final vehicleLocationProvider =
    NotifierProvider<VehicleLocationNotifier, LatLng>(() {
  return VehicleLocationNotifier();
});

final geofenceStatusProvider = Provider<bool>((ref) {
  final currentPos = ref.watch(vehicleLocationProvider);
  const currentPoint = LatLng(51.5074, -0.1278);
  const safeRadiusMeters = 200.0;

  final distance =
      const Distance().as(LengthUnit.Meter, currentPoint, currentPos);
  return distance <= safeRadiusMeters;
});
