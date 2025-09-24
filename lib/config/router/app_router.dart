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
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        return FormScreen(
          card: extras?['card'] as InfoCard?,
          index: extras?['index'] as int?,
        );
      },
    ),
    GoRoute(
      path: '/details',
      name: DetailsScreen.routeName,
      builder: (context, state) => DetailsScreen(card: state.extra as InfoCard),
    ),
  ],
);
