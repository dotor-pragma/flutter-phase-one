import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/screens/screens.dart';
import 'package:fase_1/presentation/widgets/widgets.dart';

typedef HomeFeedbackCallback = void Function(String message, {bool isError});

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.onCreateCard,
    required this.onEditCard,
    required this.onShowDetails,
    required this.onFeedback,
  });

  final VoidCallback onCreateCard;
  final void Function(FormScreenArgs args) onEditCard;
  final void Function(DetailsScreenArgs args) onShowDetails;
  final HomeFeedbackCallback onFeedback;

  @override
  Widget build(BuildContext context) {
    final cards = context.select((CardsProvider provider) => provider.cards);
    final totalCards = context.select(
      (CardsProvider provider) => provider.totalCards,
    );
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.08),
            theme.colorScheme.surface,
          ],
        ),
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: HomeHeader(
                totalCards: totalCards,
                onCreatePressed: onCreateCard,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchOutCurve: Curves.easeInBack,
              child: cards.isEmpty
                  ? HomeEmptyState(onCreateCard: onCreateCard)
                  : const SizedBox.shrink(),
            ),
          ),
          if (cards.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 120),
              sliver: SliverList.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  final heroTag = 'info-card-$index-${card.title.hashCode}';
                  final accentColor =
                      Colors.primaries[index % Colors.primaries.length];

                  return AnimatedCardItem(
                    card: card,
                    index: index,
                    heroTag: heroTag,
                    accentColor: accentColor,
                    dismissKey: ValueKey(
                      '${card.title}-${card.description}-$index',
                    ),
                    onTap: () => onShowDetails(
                      DetailsScreenArgs(
                        card: card,
                        index: index,
                        heroTag: heroTag,
                      ),
                    ),
                    onEdit: () => onEditCard(
                      FormScreenArgs.edit(card: card, index: index),
                    ),
                    onDelete: () =>
                        _confirmDeletion(context, index: index, card: card),
                    onConfirmDismiss: () =>
                        _confirmDeletion(context, index: index, card: card),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<bool> _confirmDeletion(
    BuildContext context, {
    required int index,
    required InfoCard card,
  }) async {
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ConfirmDeleteSheet(cardTitle: card.title),
    );

    if (!context.mounted) return false;
    if (confirmed != true) {
      return false;
    }

    final provider = context.read<CardsProvider>();
    final removed = provider.removeCard(index);
    if (removed == null) {
      onFeedback(
        'No fue posible eliminar la tarjeta. Intenta nuevamente.',
        isError: true,
      );
      return false;
    }

    onFeedback('Tarjeta eliminada 🗑️');
    return true;
  }
}

class ConfirmDeleteSheet extends StatelessWidget {
  const ConfirmDeleteSheet({super.key, required this.cardTitle});

  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.delete_forever_rounded,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 12),
                Text(
                  'Eliminar tarjeta',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '¿Seguro que deseas eliminar "$cardTitle"? Esta acción no se puede deshacer.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Eliminar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
