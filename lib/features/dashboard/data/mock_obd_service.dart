import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockOBDService {
  Stream<Map<String, double>> getVehicleDataStream() {
    return Stream.periodic(const Duration(milliseconds: 100), (tick) {
      return {
        'rpm': 800 + (2500 * (1 + sin(tick * 0.1))),
        'speed': 40 + (20 * (1 + cos(tick * 0.05)))
      };
    });
  }
}

final vehcileStreamProvider = StreamProvider<Map<String, double>>((ref) {
  return MockOBDService().getVehicleDataStream();
});
