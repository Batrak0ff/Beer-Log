import '../../../core/database/app_database.dart';
import '../../../core/database/daos/tasting_entry_dao.dart';

/// Thin repository over [TastingEntryDao].
///
/// UI / providers talk to the repository, never to the DAO directly (AGENTS.md).
class TastingEntryRepository {
  TastingEntryRepository(this._dao);

  final TastingEntryDao _dao;

  Stream<List<TastingEntry>> watchAll() => _dao.watchAll();

  Future<TastingEntry?> getById(String id) => _dao.getById(id);
}
