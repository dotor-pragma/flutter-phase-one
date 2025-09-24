import 'package:fase_1/domain/repositories/cards_repository.dart';

class DeleteCardUseCase {
  const DeleteCardUseCase(this._repository);

  final CardsRepository _repository;

  void call(int index) {
    _repository.deleteCard(index);
  }
}
