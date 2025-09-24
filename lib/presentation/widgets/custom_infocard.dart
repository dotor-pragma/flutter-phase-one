import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fase_1/domain/entities/info_card.dart';

class CustomInfoCard extends StatelessWidget {
  final InfoCard card;
  final int index;
  final VoidCallback onDelete;

  const CustomInfoCard({
    super.key,
    required this.card,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go('/details', extra: card),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        card.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        card.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(
                            alpha: 0.7,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _CardActionButton(
                  icon: Icons.edit_outlined,
                  tooltip: 'Editar',
                  backgroundColor: theme.colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                  iconColor: theme.colorScheme.primary,
                  onPressed: () => context.go(
                    '/form',
                    extra: {'card': card, 'index': index},
                  ),
                ),
                const SizedBox(width: 8),
                _CardActionButton(
                  icon: Icons.delete_outline,
                  tooltip: 'Eliminar',
                  backgroundColor: theme.colorScheme.error.withValues(
                    alpha: 0.1,
                  ),
                  iconColor: theme.colorScheme.error,
                  onPressed: onDelete,
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardActionButton extends StatelessWidget {
  const _CardActionButton({
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconColor,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }
}
