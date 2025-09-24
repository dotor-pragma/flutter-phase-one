import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/screens/details_screen.dart';
import 'package:fase_1/presentation/screens/form_screen.dart';
import 'package:fase_1/presentation/widgets/custom_infocard.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Tu biblioteca de ideas'), elevation: 0),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Nueva tarjeta'),
      ),
      body: _HomeView(
        onCreateCard: () => _openForm(context),
        onEditCard: (args) => _openForm(context, args: args),
        onShowDetails: (args) => _openDetails(context, args),
        onFeedback: (message, {isError = false}) =>
            _showFeedback(context, message, isError: isError),
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context, {
    FormScreenArgs args = const FormScreenArgs.create(),
  }) async {
    final result = await context.pushNamed<FormResult?>(
      FormScreen.routeName,
      extra: args,
    );

    if (!context.mounted) return;

    if (result == null) return;

    switch (result) {
      case FormResult.created:
        _showFeedback(context, 'Tarjeta creada con éxito ✨');
        break;
      case FormResult.updated:
        _showFeedback(context, 'Cambios guardados correctamente ✅');
        break;
    }
  }

  void _openDetails(BuildContext context, DetailsScreenArgs args) {
    context.pushNamed(DetailsScreen.routeName, extra: args);
  }

  void _showFeedback(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    required this.onCreateCard,
    required this.onEditCard,
    required this.onShowDetails,
    required this.onFeedback,
  });

  final VoidCallback onCreateCard;
  final void Function(FormScreenArgs args) onEditCard;
  final void Function(DetailsScreenArgs args) onShowDetails;
  final void Function(String message, {bool isError}) onFeedback;

  @override
  Widget build(BuildContext context) {
    final cardsProvider = context.watch<CardsProvider>();
    final cards = cardsProvider.cards;
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
              child: _HomeHeader(
                totalCards: cardsProvider.totalCards,
                onCreatePressed: onCreateCard,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchOutCurve: Curves.easeInBack,
              child: cards.isEmpty
                  ? _HomeEmptyState(onCreateCard: onCreateCard)
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

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Dismissible(
                      key: ValueKey('${card.title}-${card.description}-$index'),
                      direction: DismissDirection.endToStart,
                      background: const _CardDismissBackground(),
                      confirmDismiss: (_) =>
                          _confirmDeletion(context, cardsProvider, index, card),
                      onDismissed: (_) {
                        onFeedback('Tarjeta eliminada 🗑️');
                      },
                      child: CustomInfoCard(
                        index: index,
                        card: card,
                        heroTag: heroTag,
                        accentColor: accentColor,
                        onTap: () => onShowDetails(
                          DetailsScreenArgs(card: card, heroTag: heroTag),
                        ),
                        onEdit: () => onEditCard(
                          FormScreenArgs.edit(card: card, index: index),
                        ),
                        onDelete: () async {
                          final shouldDelete = await _confirmDeletion(
                            context,
                            cardsProvider,
                            index,
                            card,
                          );
                          if (shouldDelete) {
                            onFeedback('Tarjeta eliminada 🗑️');
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<bool> _confirmDeletion(
    BuildContext context,
    CardsProvider provider,
    int index,
    InfoCard card,
  ) async {
    final theme = Theme.of(context);
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
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
                  '¿Seguro que deseas eliminar "${card.title}"? Esta acción no se puede deshacer.',
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
      },
    );

    if (confirmed != true) {
      return false;
    }

    final removed = provider.removeCard(index);
    if (removed == null) {
      onFeedback(
        'No fue posible eliminar la tarjeta. Intenta nuevamente.',
        isError: true,
      );
      return false;
    }
    return true;
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.totalCards, required this.onCreatePressed});

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

class _HomeEmptyState extends StatelessWidget {
  const _HomeEmptyState({required this.onCreateCard});

  final VoidCallback onCreateCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.15,
              ),
              child: Icon(
                Icons.lightbulb_rounded,
                color: theme.colorScheme.primary,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tu espacio creativo está vacío',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Crea tarjetas para guardar ideas, recetas, lecturas y todo lo que te inspire.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCreateCard,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Crear mi primera tarjeta'),
            ),
          ],
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
