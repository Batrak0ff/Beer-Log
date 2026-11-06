import 'package:drift/drift.dart';

/// Фото, привязанные к записи дегустации.
///
/// В MVP максимум 1 фото на запись (см. DECISIONS.md),
/// но схема допускает несколько с [sortOrder].
class TastingPhotos extends Table {
  TextColumn get id => text()();

  TextColumn get tastingEntryId => text()();

  TextColumn get filePath => text()();

  IntColumn get sortOrder =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
