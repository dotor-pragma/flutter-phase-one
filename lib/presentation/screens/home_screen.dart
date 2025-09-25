import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/presentation/screens/screens.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/widgets/infocard/custom_infocard.dart';

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
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final cardsProvider = context.watch<CardsProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: cardsProvider.cardsList.length,
        padding: const EdgeInsets.only(bottom: 120.0),
        itemBuilder: (context, index) {
          final card = cardsProvider.cardsList[index];
          return CustomInfoCard(
            card: card,
            onDelete: () => cardsProvider.removeCard(index),
            onEdit: () => context.pushNamed(
              FormScreen.routeName,
              extra: {'card': card, 'index': index},
            ),
            onTap: () =>
                context.pushNamed(DetailsScreen.routeName, extra: card),
          );
        },
      ),
    );
  }
}
