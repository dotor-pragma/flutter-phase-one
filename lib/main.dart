import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/config/router/app_router.dart';
import 'package:fase_1/config/theme/app_theme.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CardsProvider())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 4).getTheme(),
        routerConfig: appRouter,
      ),
    );
  }
}
