import 'package:brewlog/core/database/app_database.dart';
import 'package:brewlog/core/database/daos/tasting_entry_dao.dart';
import 'package:brewlog/core/database/sync_status.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase db;
  late TastingEntryDao dao;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    dao = db.tastingEntryDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('insert → watchAll sees entry → softDelete hides it', () async {
    final id = const Uuid().v4();
    final now = DateTime.now();

    await dao.insertEntry(
      TastingEntriesCompanion.insert(
        id: id,
        beerNameSnapshot: 'Test IPA',
        breweryNameSnapshot: const Value('Test Brewery'),
        rating: const Value(4.5),
        consumedAt: now,
        createdAt: now,
        updatedAt: now,
        syncStatus: const Value(SyncStatus.local),
      ),
    );

    final before = await dao.watchAll().first;
    expect(before, hasLength(1));
    expect(before.single.id, id);
    expect(before.single.beerNameSnapshot, 'Test IPA');
    expect(before.single.rating, 4.5);
    expect(before.single.deletedAt, isNull);

    await dao.softDelete(id);

    final after = await dao.watchAll().first;
    expect(after, isEmpty);

    // Запись всё ещё есть в БД, но с deletedAt.
    final byId = await dao.getById(id);
    expect(byId, isNotNull);
    expect(byId!.deletedAt, isNotNull);
  });
}
