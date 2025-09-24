import 'package:fase_1/domain/datasources/cards_datasource.dart';
import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/domain/repositories/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  CardsRepositoryImpl(this._dataSource);

  final CardsDataSource _dataSource;

  @override
  List<InfoCard> getCards() {
    return _dataSource.fetchCards();
  }

  @override
  void addCard(InfoCard card) {
    _dataSource.saveCard(card);
  }

  @override
  void updateCard(int index, InfoCard card) {
    _dataSource.updateCard(index, card);
  }

  @override
  void deleteCard(int index) {
    _dataSource.removeCard(index);
  }
}
