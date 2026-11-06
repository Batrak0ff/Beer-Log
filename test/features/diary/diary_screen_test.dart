import 'package:brewlog/core/database/app_database.dart';
import 'package:brewlog/core/database/sync_status.dart';
import 'package:brewlog/features/diary/presentation/diary_screen.dart';
import 'package:brewlog/features/diary/presentation/providers/tasting_entry_list_provider.dart';
import 'package:brewlog/features/diary/presentation/widgets/tasting_entry_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ru');
  });

  testWidgets('empty state shows CTA button', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tastingEntryListProvider.overrideWith(
            (ref) => Stream.value(const <TastingEntry>[]),
          ),
        ],
        child: const MaterialApp(
          home: DiaryScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(
      find.textContaining('Пока нет записей'),
      findsOneWidget,
    );
    expect(find.text('Добавить'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('list with 2 entries renders 2 cards', (tester) async {
    final now = DateTime(2026, 10, 12);
    final entries = [
      TastingEntry(
        id: 'id-1',
        beerId: null,
        beerNameSnapshot: 'Test IPA',
        breweryNameSnapshot: 'Brew Co',
        styleNameSnapshot: 'IPA',
        volumeMl: null,
        abvSnapshot: 6.5,
        rating: 4.5,
        notes: null,
        customPlace: null,
        consumedAt: now,
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
        syncStatus: SyncStatus.local,
      ),
      TastingEntry(
        id: 'id-2',
        beerId: null,
        beerNameSnapshot: 'Dark Lager',
        breweryNameSnapshot: null,
        styleNameSnapshot: 'Lager',
        volumeMl: null,
        abvSnapshot: null,
        rating: 3.0,
        notes: null,
        customPlace: null,
        consumedAt: now.subtract(const Duration(days: 1)),
        createdAt: now,
        updatedAt: now,
        deletedAt: null,
        syncStatus: SyncStatus.local,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tastingEntryListProvider.overrideWith(
            (ref) => Stream.value(entries),
          ),
        ],
        child: const MaterialApp(
          home: DiaryScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TastingEntryCard), findsNWidgets(2));
    expect(find.text('Test IPA'), findsOneWidget);
    expect(find.text('Dark Lager'), findsOneWidget);
  });
}
