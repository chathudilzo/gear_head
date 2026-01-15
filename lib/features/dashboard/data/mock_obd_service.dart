import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockOBDService {
  Stream<Map<String, dynamic>> getVehicleDataStream() {
    return Stream.periodic(const Duration(milliseconds: 100), (tick) {
      return {
        'rpm': 800 + (2500 * (1 + sin(tick * 0.1))),
        'speed': 40 + (20 * (1 + cos(tick * 0.05))),
        'temp': 90 + (5 * sin(tick * 0.01)),
        'voltage': 13.8 + (0.4 * cos(tick * 0.02)),
        'load': 20 + (15 * (1 + sin(tick * 0.08))),
        'fuel': 75.0 - (tick * 0.0001),
        'oil': 88.0,
        'status': tick % 100 == 0 ? "P0101" : "HEALTHY"
      };
    });
  }
}

final vehcileStreamProvider = StreamProvider<Map<String, dynamic>>((ref) {
  return MockOBDService().getVehicleDataStream();
});
