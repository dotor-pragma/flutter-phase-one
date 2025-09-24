import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/domain/repositories/cards_repository.dart';

class GetCardsUseCase {
  const GetCardsUseCase(this._repository);

  final CardsRepository _repository;

  List<InfoCard> call() {
    return _repository.getCards();
  }
}
