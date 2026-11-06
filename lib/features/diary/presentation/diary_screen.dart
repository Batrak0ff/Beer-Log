import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/router.dart';
import 'providers/tasting_entry_list_provider.dart';
import 'widgets/diary_empty_state.dart';
import 'widgets/tasting_entry_card.dart';

class DiaryScreen extends ConsumerWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncEntries = ref.watch(tastingEntryListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Дневник')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(routerProvider).push('/tasting/new'),
        tooltip: 'Новая дегустация',
        child: const Icon(Icons.add),
      ),
      body: asyncEntries.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stack) => _DiaryError(
          message: error.toString(),
          onRetry: () => ref.invalidate(tastingEntryListProvider),
        ),
        data: (entries) {
          if (entries.isEmpty) {
            return DiaryEmptyState(
              onAddPressed: () =>
                  ref.read(routerProvider).push('/tasting/new'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(tastingEntryListProvider);
              await ref.read(tastingEntryListProvider.future);
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 8, bottom: 88),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return TastingEntryCard(
                  entry: entry,
                  onTap: () => ref
                      .read(routerProvider)
                      .push('/tasting/${entry.id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _DiaryError extends StatelessWidget {
  const _DiaryError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Не удалось загрузить дневник',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
