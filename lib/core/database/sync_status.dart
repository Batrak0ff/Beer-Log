/// Статус синхронизации записи.
///
/// В MVP все записи остаются [local]. Значения [pending] и [synced]
/// зарезервированы на будущее.
enum SyncStatus {
  local,
  pending,
  synced,
}
