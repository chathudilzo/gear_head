import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gear_head/features/maintenance/data/database/database.dart';
import 'package:gear_head/features/tracking/google_tracking/data/google_tacking_provider.dart';
import 'package:gear_head/main.dart';

final alertLoggerProvider = Provider<void>((ref) {
  ref.listen(vehcileTrackingProvider, (previous, next) async {
    if (previous?.isSafe == true && next.isSafe == false) {
      final db = ref.read(databaseProvider);

      await db.logAlert(AlertLogsCompanion.insert(
          type: "GEOFENCE_BREACH",
          timestamp: DateTime.now(),
          message: 'vehcile exited 300m zone',
          latitude: Value(next.position.latitude),
          longitude: Value(next.position.longitude)));
    }
  });
});
