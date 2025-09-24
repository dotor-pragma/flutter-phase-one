import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';

class FormScreen extends StatelessWidget {
  static const String routeName = 'form_screen';
  final InfoCard? card;
  final int? index;
  const FormScreen({super.key, this.card, this.index});

  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(card?.title ?? 'Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: card?.title ?? ''),
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: card?.description ?? ''),
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (card != null) {
                  cardsProvider.editCard(
                    index!,
                    title: card!.title,
                    description: card!.description,
                  );
                } else {
                  cardsProvider.addCard(card!.title, card!.description);
                }
                context.pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
