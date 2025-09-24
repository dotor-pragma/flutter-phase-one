import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/config/router/app_router.dart';
import 'package:fase_1/config/theme/app_theme.dart';
import 'package:fase_1/domain/repositories/cards_repository.dart';
import 'package:fase_1/domain/usecases/cards/add_card_usecase.dart';
import 'package:fase_1/domain/usecases/cards/delete_card_usecase.dart';
import 'package:fase_1/domain/usecases/cards/get_cards_usecase.dart';
import 'package:fase_1/domain/usecases/cards/update_card_usecase.dart';
import 'package:fase_1/infrastructure/datasources/local_cards_datasource.dart';
import 'package:fase_1/infrastructure/repositories/cards_repository_impl.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';

void main() {
  final cardsDataSource = LocalCardsDataSource();
  final cardsRepository = CardsRepositoryImpl(cardsDataSource);

  runApp(MainApp(cardsRepository: cardsRepository));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.cardsRepository});

  final CardsRepository cardsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardsProvider(
            getCards: GetCardsUseCase(cardsRepository),
            addCard: AddCardUseCase(cardsRepository),
            updateCard: UpdateCardUseCase(cardsRepository),
            deleteCard: DeleteCardUseCase(cardsRepository),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 4).getTheme(),
        routerConfig: appRouter,
      ),
    );
  }
}
