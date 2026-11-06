import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/beers.dart';

part 'beer_dao.g.dart';

@DriftAccessor(tables: [Beers])
class BeerDao extends DatabaseAccessor<AppDatabase> with _$BeerDaoMixin {
  BeerDao(super.db);

  /// Поиск по имени (case-insensitive LIKE), только неудалённые.
  Future<List<Beer>> searchByName(String query) {
    final pattern = '%${query.trim().toLowerCase()}%';
    return (select(beers)
          ..where(
            (t) =>
                t.deletedAt.isNull() & t.name.lower().like(pattern),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<Beer?> getById(String id) {
    return (select(beers)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
