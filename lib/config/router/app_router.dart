import 'package:go_router/go_router.dart';
import 'package:fase_1/presentation/screens/screens.dart';
import 'package:fase_1/domain/entities/info_card.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/form',
      name: FormScreen.routeName,
      builder: (context, state) => const FormScreen(),
    ),
    GoRoute(
      path: '/details',
      name: DetailsScreen.routeName,
      builder: (context, state) => DetailsScreen(card: state.extra as InfoCard),
    ),
  ],
);
