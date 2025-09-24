import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fase_1/presentation/screens/details_screen.dart';
import 'package:fase_1/presentation/screens/form_screen.dart';
import 'package:fase_1/presentation/widgets/home/home.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(title: const Text('Tu biblioteca de ideas'), elevation: 0),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(context),
        icon: const Icon(Icons.add_circle_outline),
        label: const Text('Nueva tarjeta'),
      ),
      body: HomeView(
        onCreateCard: () => _openForm(context),
        onEditCard: (args) => _openForm(context, args: args),
        onShowDetails: (args) => _openDetails(context, args),
        onFeedback: (message, {isError = false}) =>
            _showFeedback(context, message, isError: isError),
      ),
    );
  }

  Future<void> _openForm(
    BuildContext context, {
    FormScreenArgs args = const FormScreenArgs.create(),
  }) async {
    final result = await context.pushNamed<FormResult?>(
      FormScreen.routeName,
      extra: args,
    );

    if (!context.mounted) return;

    if (result == null) return;

    switch (result) {
      case FormResult.created:
        _showFeedback(context, 'Tarjeta creada con éxito ✨');
        break;
      case FormResult.updated:
        _showFeedback(context, 'Cambios guardados correctamente ✅');
        break;
    }
  }

  void _openDetails(BuildContext context, DetailsScreenArgs args) {
    context.pushNamed(DetailsScreen.routeName, extra: args);
  }

  void _showFeedback(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }
}
