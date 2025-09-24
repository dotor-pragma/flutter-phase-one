import 'package:fase_1/domain/entities/info_card.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = 'details_screen';
  final InfoCard card;

  const DetailsScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(card.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(card.description),
      ),
    );
  }
}
