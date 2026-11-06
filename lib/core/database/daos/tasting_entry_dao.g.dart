// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasting_entry_dao.dart';

// ignore_for_file: type=lint
mixin _$TastingEntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $TastingEntriesTable get tastingEntries => attachedDatabase.tastingEntries;
  TastingEntryDaoManager get managers => TastingEntryDaoManager(this);
}

class TastingEntryDaoManager {
  final _$TastingEntryDaoMixin _db;
  TastingEntryDaoManager(this._db);
  $$TastingEntriesTableTableManager get tastingEntries =>
      $$TastingEntriesTableTableManager(
        _db.attachedDatabase,
        _db.tastingEntries,
      );
}
