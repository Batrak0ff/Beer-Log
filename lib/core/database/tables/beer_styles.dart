import 'package:drift/drift.dart';

/// Стили пива (иерархия через [parentStyleId]).
///
/// Soft-delete и syncStatus не используются — стили считаются
/// справочником и удаляются редко/никогда.
class BeerStyles extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  TextColumn get parentStyleId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
