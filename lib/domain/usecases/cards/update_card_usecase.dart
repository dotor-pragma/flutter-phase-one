import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/domain/repositories/cards_repository.dart';

class UpdateCardUseCase {
  const UpdateCardUseCase(this._repository);

  final CardsRepository _repository;

  void call(int index, InfoCard card) {
    _repository.updateCard(index, card);
  }
}
