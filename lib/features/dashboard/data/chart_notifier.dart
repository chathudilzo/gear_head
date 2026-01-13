import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/features/dashboard/data/mock_obd_service.dart';

class ChartNotifier extends FamilyNotifier<List<FlSpot>, String> {
  List<FlSpot> build(String dataType) {
    ref.listen(vehcileStreamProvider, (previous, next) {
      next.whenData((data) {
        final value = data[dataType] ?? 0.0;
        _updateList(value);
      });
    });

    return const [];
  }

  void _updateList(double newValue) {
    final List<FlSpot> points = List.from(state);
    double nextX = points.isEmpty ? 0 : points.last.x + 1;

    points.add(FlSpot(nextX, newValue));

    if (points.length > 50) {
      points.removeAt(0);
    }

    state = points;
  }
}

final chartProvider =
    NotifierProvider.family<ChartNotifier, List<FlSpot>, String>(
        () => ChartNotifier());
