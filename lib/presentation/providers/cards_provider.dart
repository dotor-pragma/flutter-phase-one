import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/domain/usecases/cards/add_card_usecase.dart';
import 'package:fase_1/domain/usecases/cards/delete_card_usecase.dart';
import 'package:fase_1/domain/usecases/cards/get_cards_usecase.dart';
import 'package:fase_1/domain/usecases/cards/update_card_usecase.dart';

class CardsProvider extends ChangeNotifier {
  CardsProvider({
    required GetCardsUseCase getCards,
    required AddCardUseCase addCard,
    required UpdateCardUseCase updateCard,
    required DeleteCardUseCase deleteCard,
  }) : _getCards = getCards,
       _addCard = addCard,
       _updateCard = updateCard,
       _deleteCard = deleteCard,
       _cards = getCards();

  final GetCardsUseCase _getCards;
  final AddCardUseCase _addCard;
  final UpdateCardUseCase _updateCard;
  final DeleteCardUseCase _deleteCard;

  List<InfoCard> _cards;

  UnmodifiableListView<InfoCard> get cards => UnmodifiableListView(_cards);

  void addNewCard({required String title, required String description}) {
    if (title.trim().isEmpty || description.trim().isEmpty) return;

    final newCard = InfoCard(
      title: title.trim(),
      description: description.trim(),
    );
    _addCard(newCard);
    _refreshCards();
  }

  void updateExistingCard(
    int index, {
    required String title,
    required String description,
  }) {
    if (title.trim().isEmpty || description.trim().isEmpty) return;
    if (index < 0 || index >= _cards.length) return;

    final updatedCard = InfoCard(
      title: title.trim(),
      description: description.trim(),
    );
    _updateCard(index, updatedCard);
    _refreshCards();
  }

  void removeCard(int index) {
    if (index < 0 || index >= _cards.length) return;
    _deleteCard(index);
    _refreshCards();
  }

  void _refreshCards() {
    _cards = _getCards();
    notifyListeners();
  }
}
