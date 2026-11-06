import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/database/app_database.dart';

/// Compact card for one diary entry (snapshot fields only).
class TastingEntryCard extends StatelessWidget {
  const TastingEntryCard({
    required this.entry,
    required this.onTap,
    super.key,
  });

  final TastingEntry entry;
  final VoidCallback onTap;

  static final DateFormat _dateFormat = DateFormat('d MMM yyyy', 'ru');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brewery = entry.breweryNameSnapshot?.trim();
    final style = entry.styleNameSnapshot?.trim();
    final rating = entry.rating;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      entry.beerNameSnapshot,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (rating != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      '${_formatRating(rating)} ★',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
              if (brewery != null && brewery.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  brewery,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (style != null && style.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  style,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                _dateFormat.format(entry.consumedAt),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatRating(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }
}
