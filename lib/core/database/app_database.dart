import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/beer_dao.dart';
import 'daos/tasting_entry_dao.dart';
import 'sync_status.dart';
import 'tables/app_settings.dart';
import 'tables/beer_styles.dart';
import 'tables/beers.dart';
import 'tables/breweries.dart';
import 'tables/tasting_entries.dart';
import 'tables/tasting_photos.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Beers,
    Breweries,
    BeerStyles,
    TastingEntries,
    TastingPhotos,
    AppSettings,
  ],
  daos: [
    TastingEntryDao,
    BeerDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Для unit-тестов (in-memory).
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Singleton AppSettings (id = 1).
        await into(appSettings).insert(
          const AppSettingsCompanion(id: Value(1)),
        );
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'brewlog.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
