import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/domain/usecases/cards/cards.dart';

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
  int get totalCards => _cards.length;

  bool addNewCard({required String title, required String description}) {
    if (title.trim().isEmpty || description.trim().isEmpty) {
      return false;
    }

    final newCard = InfoCard(
      title: title.trim(),
      description: description.trim(),
    );
    _addCard(newCard);
    _refreshCards();
    return true;
  }

  bool updateExistingCard(
    int index, {
    required String title,
    required String description,
  }) {
    if (title.trim().isEmpty || description.trim().isEmpty) {
      return false;
    }
    if (index < 0 || index >= _cards.length) {
      return false;
    }

    final updatedCard = InfoCard(
      title: title.trim(),
      description: description.trim(),
    );
    _updateCard(index, updatedCard);
    _refreshCards();
    return true;
  }

  InfoCard? removeCard(int index) {
    if (index < 0 || index >= _cards.length) {
      return null;
    }

    final removedCard = _cards[index];
    _deleteCard(index);
    _refreshCards();
    return removedCard;
  }

  void _refreshCards() {
    _cards = _getCards();
    notifyListeners();
  }
}
