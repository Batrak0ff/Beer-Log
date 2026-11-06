import 'package:drift/drift.dart';

import '../sync_status.dart';

/// Пивоварни.
class Breweries extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get country => text().nullable()();

  TextColumn get city => text().nullable()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  DateTimeColumn get deletedAt => dateTime().nullable()();

  TextColumn get syncStatus => textEnum<SyncStatus>()
      .withDefault(const Constant('local'))();

  @override
  Set<Column> get primaryKey => {id};
}
