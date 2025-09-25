import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/widgets/infocard/card_action_btn.dart';

class InfoCardContent extends StatelessWidget {
  const InfoCardContent({
    super.key,
    required this.card,
    required this.theme,
    required this.onEdit,
    required this.onDelete,
  });

  final InfoCard card;
  final ThemeData theme;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                card.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.8,
                  ),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CardActionButton(
          icon: Icons.edit_outlined,
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          iconColor: theme.colorScheme.primary,
          onPressed: onEdit,
        ),
        const SizedBox(width: 8),
        CardActionButton(
          icon: Icons.delete_outline,
          backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
          iconColor: theme.colorScheme.error,
          onPressed: onDelete,
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.chevron_right,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
        ),
      ],
    );
  }
}
