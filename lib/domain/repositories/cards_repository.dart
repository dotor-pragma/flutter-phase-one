import 'package:fase_1/domain/entities/info_card.dart';

/// Contract that isolates the domain layer from specific data implementations.
abstract interface class CardsRepository {
  List<InfoCard> getCards();
  void addCard(InfoCard card);
  void updateCard(int index, InfoCard card);
  void deleteCard(int index);
}
