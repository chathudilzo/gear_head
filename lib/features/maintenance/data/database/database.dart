import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class AlertLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get message => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
}

@DriftDatabase(tables: [AlertLogs])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> logAlert(AlertLogsCompanion entry) {
    return into(alertLogs).insert(entry);
  }

  Stream<List<AlertLog>> watchAllAlerts() {
    return select(alertLogs).watch();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationCacheDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
