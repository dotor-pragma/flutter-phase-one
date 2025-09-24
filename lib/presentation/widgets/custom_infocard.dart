import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    super.key,
    required this.index,
    required this.card,
    required this.heroTag,
    required this.accentColor,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  });

  final int index;
  final InfoCard card;
  final String heroTag;
  final Color accentColor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Hero(
      tag: heroTag,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accentColor.withValues(alpha: 0.16),
                  accentColor.withValues(alpha: 0.08),
                ],
              ),
              border: Border.all(color: accentColor.withValues(alpha: 0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _AvatarBadge(index: index, accentColor: accentColor),
                      const Spacer(),
                      _CardActionButton(
                        icon: Icons.edit_outlined,
                        tooltip: 'Editar',
                        iconColor: accentColor,
                        onPressed: onEdit,
                      ),
                      const SizedBox(width: 8),
                      _CardActionButton(
                        icon: Icons.delete_outline,
                        tooltip: 'Eliminar',
                        iconColor: theme.colorScheme.error,
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    card.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: onSurface.withValues(alpha: 0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    card.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: onSurface.withValues(alpha: 0.7),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ver detalle',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 20,
                          color: accentColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    required this.iconColor,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton.filledTonal(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: iconColor),
        style: IconButton.styleFrom(
          backgroundColor: iconColor.withValues(alpha: 0.1),
          foregroundColor: iconColor,
          minimumSize: const Size.square(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({required this.index, required this.accentColor});

  final int index;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      radius: 22,
      backgroundColor: accentColor.withValues(alpha: 0.15),
      child: Text(
        '#${index + 1}',
        style: theme.textTheme.labelLarge?.copyWith(
          color: accentColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
