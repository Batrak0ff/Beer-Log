import 'package:drift/drift.dart';

import '../sync_status.dart';

/// Записи дегустации (дневник).
///
/// Snapshot-поля сохраняют название/стиль/ABV на момент записи,
/// чтобы правки каталога не меняли историю.
@TableIndex(name: 'idx_tasting_entries_consumed_at', columns: {#consumedAt})
@TableIndex(name: 'idx_tasting_entries_deleted_at', columns: {#deletedAt})
class TastingEntries extends Table {
  TextColumn get id => text()();

  TextColumn get beerId => text().nullable()();

  /// Обязательный snapshot названия пива.
  TextColumn get beerNameSnapshot => text()();

  TextColumn get breweryNameSnapshot => text().nullable()();

  TextColumn get styleNameSnapshot => text().nullable()();

  IntColumn get volumeMl => integer().nullable()();

  RealColumn get abvSnapshot => real().nullable()();

  /// Оценка 1.0–5.0, шаг 0.5 (см. DECISIONS.md).
  RealColumn get rating => real().nullable()();

  TextColumn get notes => text().nullable()();

  TextColumn get customPlace => text().nullable()();

  DateTimeColumn get consumedAt => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  TextColumn get syncStatus => textEnum<SyncStatus>()
      .withDefault(const Constant('local'))();

  @override
  Set<Column> get primaryKey => {id};
}
