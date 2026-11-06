# AGENTS.md — BrewLog

Этот файл — источник правды по стеку, архитектуре и ограничениям.
Читай его перед любым изменением кода. Если запрос противоречит файлу — спроси, не догадывайся.

## 1. Стек (не менять без явного запроса пользователя)
- Flutter 3.x, Dart 3.x (null safety, sound)
- Drift (SQLite) — единственная БД. Никакого Firebase, Hive, Isar, sqflite.
- Riverpod (flutter_riverpod + riverpod_generator + riverpod_annotation)
- GoRouter (go_router)
- Пакеты MVP: image_picker, path_provider, uuid, intl, fl_chart, file_picker, shared_preferences
- build_runner для кодогенерации (Drift, Riverpod, json_serializable)

Любой новый пакет — только после явного «ок» от пользователя.

## 2. Архитектура
- Feature-first: `lib/features/<feature>/{data,domain,presentation}`
- Repository pattern между UI и Drift DAO. UI никогда не обращается к БД напрямую.
- Offline-first: всё работает без сети. В MVP нет ни одного сетевого вызова.
- Навигация — только через GoRouter. Никаких Navigator.push напрямую.
- Тема — Material 3, dark-only на MVP.

## 3. Правила домена (критично)
- `Beer` и `TastingEntry` — РАЗНЫЕ сущности. Никогда не мержить и не путать.
- `TastingEntry` хранит *Snapshot-поля (`beerNameSnapshot`, `breweryNameSnapshot`, `styleNameSnapshot`, `abvSnapshot`). Правка каталога не должна менять историю дневника.
- Удаление — soft delete: ставим `deletedAt`, никогда `DELETE FROM`.
- Все запросы по умолчанию фильтруют `deletedAt IS NULL`.
- Все ID — UUID (String). Никаких auto-increment.
- У изменяемых сущностей есть `createdAt`, `updatedAt`, `deletedAt`, `syncStatus` (enum: local, pending, synced).

## 4. Правила кода
- Никаких `print()`. Только `debugPrint` или логгер.
- Никакого `dynamic`. Внешние данные — `Object?` / `Map<String, Object?>` + сужение.
- Никакого `!` без доказанной проверки на null выше по коду.
- Всё, что может быть `const`, — `const`.
- `StatelessWidget` предпочтительнее `StatefulWidget`. Локальный state — только если без него никак.
- Виджет длиннее 80 строк — разбить на приватные виджеты.
- После каждого `await` в State — `if (!mounted) return;` перед `setState`/`context`.
- Никаких `Future.then().catchError()`. Только `try/await/catch` с типизированными ошибками.
- Модели — immutable, `final` поля, `const` конструктор, `copyWith` / `fromJson` / `toJson`.

## 5. Процесс работы
- Сначала план по файлам → ждёшь «ок» → потом код.
- Один вертикальный срез = один коммит. Не смешивать фичи.
- Тесты обязательны для: Drift DAO, репозиториев, форм. Widget-тесты — для ключевых экранов.
- Не трогать чужие файлы вне текущей задачи без запроса.
- После генерации — прогонять `flutter analyze` и `flutter test`. Ошибки чинить, а не игнорировать.

## 6. Запрещено (жёстко)
- Соцфичи, лайки, шеринг, подписки, комментарии, рекомендации.
- Геймификация, достижения, уровни, «цели по выпитому».
- Аналитика, crash-репортинг, любые SDK, собирающие данные (Firebase Analytics, Sentry, Amplitude и т.п.).
- Реклама, ссылки на покупку пива, промо-тексты производителей.
- Облачная синхронизация, авторизация, любые сетевые API в MVP.
- Автоматическое распознавание пива по фото.

## 7. Что делать при неопределённости
- Если запрос допускает 2+ трактовки — задай вопрос, не выбирай молча.
- Если для задачи нужен новый пакет или таблица — сначала предложи, потом делай.
- Если видишь, что фича раздувает MVP — скажи об этом явно.