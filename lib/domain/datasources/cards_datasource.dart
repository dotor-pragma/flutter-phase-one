import 'package:fase_1/domain/entities/info_card.dart';

/// Abstracción de la fuente de datos para tarjetas.
abstract interface class CardsDataSource {
  List<InfoCard> fetchCards();
  void saveCard(InfoCard card);
  void updateCard(int index, InfoCard card);
  void removeCard(int index);
}
