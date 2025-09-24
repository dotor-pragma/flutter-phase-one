import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';

class CardsProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  List<InfoCard> cardsList = [
    InfoCard(title: 'Card 1', description: 'Description 1'),
    InfoCard(title: 'Card 2', description: 'Description 2'),
  ];

  void addCard(String title, String description) {
    if (title.isEmpty || description.isEmpty) return;

    final newCard = InfoCard(title: title, description: description);

    cardsList.add(newCard);
    notifyListeners();
  }

  void removeCard(int index) {
    cardsList.removeAt(index);
    notifyListeners();
  }

  void editCard(
    int index, {
    required String title,
    required String description,
  }) {
    cardsList[index] = InfoCard(title: title, description: description);
    notifyListeners();
  }
}
