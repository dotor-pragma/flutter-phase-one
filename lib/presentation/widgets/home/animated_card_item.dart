import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/widgets/custom_infocard.dart';

class AnimatedCardItem extends StatelessWidget {
  const AnimatedCardItem({
    super.key,
    required this.card,
    required this.index,
    required this.heroTag,
    required this.accentColor,
    required this.dismissKey,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onConfirmDismiss,
  });

  final InfoCard card;
  final int index;
  final String heroTag;
  final Color accentColor;
  final Key dismissKey;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final Future<bool> Function() onConfirmDismiss;
  final Future<bool> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Dismissible(
        key: dismissKey,
        direction: DismissDirection.endToStart,
        background: const _CardDismissBackground(),
        confirmDismiss: (_) => onConfirmDismiss(),
        onDismissed: (_) {},
        child: CustomInfoCard(
          index: index,
          card: card,
          heroTag: heroTag,
          accentColor: accentColor,
          onTap: onTap,
          onEdit: onEdit,
          onDelete: () async {
            await onDelete();
          },
        ),
      ),
    );
  }
}

class _CardDismissBackground extends StatelessWidget {
  const _CardDismissBackground();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme.colorScheme.error.withValues(alpha: 0.1),
      ),
      child: Icon(
        Icons.delete_outline,
        color: theme.colorScheme.error,
        size: 30,
      ),
    );
  }
}
