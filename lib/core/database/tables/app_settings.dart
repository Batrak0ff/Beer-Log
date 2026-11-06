import 'package:drift/drift.dart';

/// Singleton-настройки приложения (всегда одна строка с id = 1).
class AppSettings extends Table {
  IntColumn get id => integer()();

  TextColumn get theme =>
      text().withDefault(const Constant('dark'))();

  BoolColumn get ageConfirmed =>
      boolean().withDefault(const Constant(false))();

  /// UI-шкала (например 5). Не путать с типом хранения rating (double).
  IntColumn get ratingScale =>
      integer().withDefault(const Constant(5))();

  BoolColumn get showConsumptionStats =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
