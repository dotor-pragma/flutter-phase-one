import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/domain/repositories/cards_repository.dart';

class AddCardUseCase {
  const AddCardUseCase(this._repository);

  final CardsRepository _repository;

  void call(InfoCard card) {
    _repository.addCard(card);
  }
}
