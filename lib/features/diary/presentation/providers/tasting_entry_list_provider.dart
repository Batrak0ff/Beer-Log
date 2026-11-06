import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/tasting_entry_repository.dart';

final tastingEntryRepositoryProvider = Provider<TastingEntryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TastingEntryRepository(db.tastingEntryDao);
});

/// Live list of non-deleted tasting entries (newest first).
final tastingEntryListProvider = StreamProvider<List<TastingEntry>>((ref) {
  return ref.watch(tastingEntryRepositoryProvider).watchAll();
});
