import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.totalCards,
    required this.onCreatePressed,
  });

  final int totalCards;
  final VoidCallback onCreatePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitle = totalCards == 0
        ? 'Comienza creando tu primera tarjeta inspiradora.'
        : 'Tienes $totalCards ${totalCards == 1 ? 'tarjeta' : 'tarjetas'} listas para explorar.';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Hola!',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimary.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.onPrimary,
              side: BorderSide(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.3),
              ),
            ),
            onPressed: onCreatePressed,
            icon: const Icon(Icons.add),
            label: const Text('Agregar tarjeta'),
          ),
        ],
      ),
    );
  }
}
