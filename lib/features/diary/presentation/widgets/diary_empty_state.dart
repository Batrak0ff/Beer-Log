import 'package:flutter/material.dart';

/// Empty diary: icon, message, CTA to add first tasting.
class DiaryEmptyState extends StatelessWidget {
  const DiaryEmptyState({required this.onAddPressed, super.key});

  final VoidCallback onAddPressed;

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
              Icons.sports_bar_outlined,
              size: 72,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text(
              'Пока нет записей.\nДобавьте первую дегустацию',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
              label: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
