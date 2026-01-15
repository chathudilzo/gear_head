// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AlertLogsTable extends AlertLogs
    with TableInfo<$AlertLogsTable, AlertLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlertLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, timestamp, message, latitude, longitude];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alert_logs';
  @override
  VerificationContext validateIntegrity(Insertable<AlertLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AlertLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlertLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
    );
  }

  @override
  $AlertLogsTable createAlias(String alias) {
    return $AlertLogsTable(attachedDatabase, alias);
  }
}

class AlertLog extends DataClass implements Insertable<AlertLog> {
  final int id;
  final String type;
  final DateTime timestamp;
  final String message;
  final double? latitude;
  final double? longitude;
  const AlertLog(
      {required this.id,
      required this.type,
      required this.timestamp,
      required this.message,
      this.latitude,
      this.longitude});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    return map;
  }

  AlertLogsCompanion toCompanion(bool nullToAbsent) {
    return AlertLogsCompanion(
      id: Value(id),
      type: Value(type),
      timestamp: Value(timestamp),
      message: Value(message),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
    );
  }

  factory AlertLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlertLog(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      message: serializer.fromJson<String>(json['message']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'message': serializer.toJson<String>(message),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
    };
  }

  AlertLog copyWith(
          {int? id,
          String? type,
          DateTime? timestamp,
          String? message,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent()}) =>
      AlertLog(
        id: id ?? this.id,
        type: type ?? this.type,
        timestamp: timestamp ?? this.timestamp,
        message: message ?? this.message,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
      );
  AlertLog copyWithCompanion(AlertLogsCompanion data) {
    return AlertLog(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      message: data.message.present ? data.message.value : this.message,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlertLog(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('message: $message, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, timestamp, message, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlertLog &&
          other.id == this.id &&
          other.type == this.type &&
          other.timestamp == this.timestamp &&
          other.message == this.message &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class AlertLogsCompanion extends UpdateCompanion<AlertLog> {
  final Value<int> id;
  final Value<String> type;
  final Value<DateTime> timestamp;
  final Value<String> message;
  final Value<double?> latitude;
  final Value<double?> longitude;
  const AlertLogsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.message = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  AlertLogsCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required DateTime timestamp,
    required String message,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  })  : type = Value(type),
        timestamp = Value(timestamp),
        message = Value(message);
  static Insertable<AlertLog> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<DateTime>? timestamp,
    Expression<String>? message,
    Expression<double>? latitude,
    Expression<double>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (timestamp != null) 'timestamp': timestamp,
      if (message != null) 'message': message,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  AlertLogsCompanion copyWith(
      {Value<int>? id,
      Value<String>? type,
      Value<DateTime>? timestamp,
      Value<String>? message,
      Value<double?>? latitude,
      Value<double?>? longitude}) {
    return AlertLogsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      message: message ?? this.message,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlertLogsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('timestamp: $timestamp, ')
          ..write('message: $message, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  $MyDatabaseManager get managers => $MyDatabaseManager(this);
  late final $AlertLogsTable alertLogs = $AlertLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [alertLogs];
}

typedef $$AlertLogsTableCreateCompanionBuilder = AlertLogsCompanion Function({
  Value<int> id,
  required String type,
  required DateTime timestamp,
  required String message,
  Value<double?> latitude,
  Value<double?> longitude,
});
typedef $$AlertLogsTableUpdateCompanionBuilder = AlertLogsCompanion Function({
  Value<int> id,
  Value<String> type,
  Value<DateTime> timestamp,
  Value<String> message,
  Value<double?> latitude,
  Value<double?> longitude,
});

class $$AlertLogsTableFilterComposer
    extends Composer<_$MyDatabase, $AlertLogsTable> {
  $$AlertLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));
}

class $$AlertLogsTableOrderingComposer
    extends Composer<_$MyDatabase, $AlertLogsTable> {
  $$AlertLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));
}

class $$AlertLogsTableAnnotationComposer
    extends Composer<_$MyDatabase, $AlertLogsTable> {
  $$AlertLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);
}

class $$AlertLogsTableTableManager extends RootTableManager<
    _$MyDatabase,
    $AlertLogsTable,
    AlertLog,
    $$AlertLogsTableFilterComposer,
    $$AlertLogsTableOrderingComposer,
    $$AlertLogsTableAnnotationComposer,
    $$AlertLogsTableCreateCompanionBuilder,
    $$AlertLogsTableUpdateCompanionBuilder,
    (AlertLog, BaseReferences<_$MyDatabase, $AlertLogsTable, AlertLog>),
    AlertLog,
    PrefetchHooks Function()> {
  $$AlertLogsTableTableManager(_$MyDatabase db, $AlertLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlertLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlertLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlertLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
          }) =>
              AlertLogsCompanion(
            id: id,
            type: type,
            timestamp: timestamp,
            message: message,
            latitude: latitude,
            longitude: longitude,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String type,
            required DateTime timestamp,
            required String message,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
          }) =>
              AlertLogsCompanion.insert(
            id: id,
            type: type,
            timestamp: timestamp,
            message: message,
            latitude: latitude,
            longitude: longitude,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlertLogsTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $AlertLogsTable,
    AlertLog,
    $$AlertLogsTableFilterComposer,
    $$AlertLogsTableOrderingComposer,
    $$AlertLogsTableAnnotationComposer,
    $$AlertLogsTableCreateCompanionBuilder,
    $$AlertLogsTableUpdateCompanionBuilder,
    (AlertLog, BaseReferences<_$MyDatabase, $AlertLogsTable, AlertLog>),
    AlertLog,
    PrefetchHooks Function()>;

class $MyDatabaseManager {
  final _$MyDatabase _db;
  $MyDatabaseManager(this._db);
  $$AlertLogsTableTableManager get alertLogs =>
      $$AlertLogsTableTableManager(_db, _db.alertLogs);
}
