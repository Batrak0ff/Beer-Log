import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Singleton Drift database for the app.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
