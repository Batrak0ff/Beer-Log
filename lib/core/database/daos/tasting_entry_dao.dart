import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/tasting_entries.dart';

part 'tasting_entry_dao.g.dart';

@DriftAccessor(tables: [TastingEntries])
class TastingEntryDao extends DatabaseAccessor<AppDatabase>
    with _$TastingEntryDaoMixin {
  TastingEntryDao(super.db);

  /// Все неудалённые записи, свежие сверху.
  Stream<List<TastingEntry>> watchAll() {
    return (select(tastingEntries)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.consumedAt)]))
        .watch();
  }

  Future<TastingEntry?> getById(String id) {
    return (select(tastingEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertEntry(TastingEntriesCompanion entry) {
    return into(tastingEntries).insert(entry);
  }

  Future<void> updateEntry(TastingEntriesCompanion entry) {
    final id = entry.id;
    if (!id.present) {
      throw ArgumentError('id is required for updateEntry');
    }
    return (update(tastingEntries)..where((t) => t.id.equals(id.value)))
        .write(entry);
  }

  /// Soft-delete: выставляет [deletedAt], не удаляет строку.
  Future<int> softDelete(String id) {
    return (update(tastingEntries)..where((t) => t.id.equals(id))).write(
      TastingEntriesCompanion(
        deletedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
