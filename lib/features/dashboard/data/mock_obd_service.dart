import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockOBDService {
  double _oilLife = 88.0;
  double _coolentHealth = 94.0;

  Stream<Map<String, dynamic>> getVehicleDataStream() {
    return Stream.periodic(const Duration(milliseconds: 100), (tick) {
      final double rpm = 800 + (2500 * (1 + sin(tick * 0.1)));
      final double temp = 90 + (20 * sin(tick * 0.05));

      double oilPenalty = 0.00001;
      double coolentPenalty = 0.000005;

      if (rpm > 3500) {
        oilPenalty *= 4.0;
      }

      if (temp > 102) {
        oilPenalty *= 2.0;
        coolentPenalty -= 0.0001;
      }

      _oilLife -= oilPenalty;
      _coolentHealth -= coolentPenalty;

      return {
        'rpm': rpm,
        'speed': 40 + (20 * (1 + cos(tick * 0.05))),
        'temp': temp,
        'voltage': 13.8 + (0.4 * cos(tick * 0.02)),
        'load': 20 + (15 * (1 + sin(tick * 0.08))),
        'fuel': 75.0 - (tick * 0.0001),
        'oil': _oilLife,
        'coolant': _coolentHealth,
        'status': tick % 100 == 0 ? "P0101" : "HEALTHY"
      };
    });
  }
}

final obdServiceProvider = Provider((ref) => MockOBDService());

final vehcileStreamProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final service = ref.watch(obdServiceProvider);

  return service.getVehicleDataStream();
});
