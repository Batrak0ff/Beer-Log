// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_dao.dart';

// ignore_for_file: type=lint
mixin _$BeerDaoMixin on DatabaseAccessor<AppDatabase> {
  $BeersTable get beers => attachedDatabase.beers;
  BeerDaoManager get managers => BeerDaoManager(this);
}

class BeerDaoManager {
  final _$BeerDaoMixin _db;
  BeerDaoManager(this._db);
  $$BeersTableTableManager get beers =>
      $$BeersTableTableManager(_db.attachedDatabase, _db.beers);
}
