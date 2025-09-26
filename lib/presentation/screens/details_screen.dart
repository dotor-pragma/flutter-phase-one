import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/screens/form_screen.dart';
import 'package:fase_1/presentation/widgets/infocard/card_action_btn.dart';

class DetailsScreenParams {
  final InfoCard card;
  final int index;

  DetailsScreenParams({required this.card, required this.index});

  Map<String, dynamic>? toJson() => {'card': card.toJson(), 'index': index};
}

class DetailsScreen extends StatelessWidget {
  static const String routeName = 'details_screen';

  final DetailsScreenParams params;

  const DetailsScreen({super.key, required this.params});

  InfoCard get card => params.card;
  int get index => params.index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardsProvider = context.read<CardsProvider>();
    return Scaffold(
      appBar: AppBar(title: Text(card.title, maxLines: 2)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            FormScreen.routeName,
            extra: FormScreenParams(card: card, index: index),
          );
        },
        child: const Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(card.description),
            const SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            ),
            Expanded(child: Container()),
            CardActionButton(
              icon: Icons.delete_outline,
              backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
              iconColor: theme.colorScheme.error,
              onPressed: () {
                cardsProvider.removeCard(index);
                context.pop();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
