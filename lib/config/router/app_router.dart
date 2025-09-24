import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fase_1/presentation/screens/screens.dart';

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
      pageBuilder: (context, state) {
        final args =
            state.extra as FormScreenArgs? ?? const FormScreenArgs.create();
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: FormScreen(args: args),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 220),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.05),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/details',
      name: DetailsScreen.routeName,
      pageBuilder: (context, state) {
        final args = state.extra as DetailsScreenArgs?;
        if (args == null) {
          throw ArgumentError(
            'DetailsScreenArgs are required to open DetailsScreen',
          );
        }
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: DetailsScreen(args: args),
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInBack,
            );
            return ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1).animate(curved),
              child: FadeTransition(opacity: curved, child: child),
            );
          },
        );
      },
    ),
  ],
);
