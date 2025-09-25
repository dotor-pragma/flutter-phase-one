import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/widgets/infocard/infocard_content.dart';

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    super.key,
    required this.card,
    required this.onDelete,
    required this.onEdit,
    required this.onTap,
  });

  final InfoCard card;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: InfoCardContent(
              card: card,
              theme: theme,
              onEdit: onEdit,
              onDelete: onDelete,
            ),
          ),
        ),
      ),
    );
  }
}
