import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/widgets/custom_infocard.dart';
import 'package:fase_1/presentation/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(FormScreen.routeName),
        child: const Icon(Icons.add),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final cardsProvider = context.watch<CardsProvider>();
    final cards = cardsProvider.cards;

    if (cards.isEmpty) {
      return const Center(child: Text('No hay tarjetas disponibles.'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: cards.length,
        padding: const EdgeInsets.only(bottom: 120.0),
        itemBuilder: (context, index) {
          final card = cards[index];
          return CustomInfoCard(
            card: card,
            index: index,
            onDelete: () => cardsProvider.removeCard(index),
            onEdit: () => context.pushNamed(
              FormScreen.routeName,
              extra: FormScreenArgs.edit(card: card, index: index),
            ),
            onTap: () =>
                context.pushNamed(DetailsScreen.routeName, extra: card),
          );
        },
      ),
    );
  }
}
