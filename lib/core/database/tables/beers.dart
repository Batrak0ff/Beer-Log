import 'package:drift/drift.dart';

import '../sync_status.dart';

/// Каталог пива.
@TableIndex(name: 'idx_beers_name', columns: {#name})
class Beers extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get breweryId => text().nullable()();

  TextColumn get styleId => text().nullable()();

  RealColumn get abv => real().nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get imagePath => text().nullable()();

  BoolColumn get isCustom =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  TextColumn get syncStatus => textEnum<SyncStatus>()
      .withDefault(const Constant('local'))();

  @override
  Set<Column> get primaryKey => {id};
}
