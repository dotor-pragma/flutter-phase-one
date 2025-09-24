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
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: cardsProvider.cardsList.length,
        itemBuilder: (context, index) {
          final card = cardsProvider.cardsList[index];
          return CustomInfoCard(
            card: card,
            index: index,
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
