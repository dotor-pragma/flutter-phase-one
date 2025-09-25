import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/widgets/form/form_body.dart';

class FormScreenParams {
  final InfoCard? card;
  final int? index;

  FormScreenParams({this.card, this.index});
}

class FormScreen extends StatefulWidget {
  static const String routeName = 'form_screen';

  const FormScreen({super.key, this.params});

  final FormScreenParams? params;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  InfoCard? get card => widget.params?.card;
  int? get index => widget.params?.index;

  bool get _isEditing => card != null && index != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: card?.title ?? '');
    _descriptionController = TextEditingController(
      text: card?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    // Cierra el teclado (o quita el foco) de cualquier campo de texto activo en la pantalla.
    FocusScope.of(context).unfocus();

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) return;

    final cardsProvider = context.read<CardsProvider>();

    if (_isEditing) {
      final hasChanges =
          title != card!.title || description != card!.description;
      if (!hasChanges) {
        context.pop();
        return;
      }
      cardsProvider.editCard(index!, title: title, description: description);
    } else {
      cardsProvider.addCard(title, description);
    }

    // Cierra la pantalla actual (la pantalla de formulario)
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTitle = _isEditing ? 'Editar tarjeta' : 'Nueva tarjeta';

    return Scaffold(
      appBar: AppBar(title: Text(defaultTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBody(
          titleController: _titleController,
          descriptionController: _descriptionController,
          onSave: _handleSave,
        ),
      ),
    );
  }
}
