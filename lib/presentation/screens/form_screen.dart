import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';
import 'package:fase_1/presentation/widgets/form/form_body.dart';

class FormScreen extends StatefulWidget {
  static const String routeName = 'form_screen';
  final InfoCard? card;
  final int? index;

  const FormScreen({super.key, this.card, this.index});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  bool get _isEditing => widget.card != null && widget.index != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.card?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.card?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    FocusScope.of(context).unfocus();

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    if (title.isEmpty || description.isEmpty) return;
    final cardsProvider = context.read<CardsProvider>();

    if (_isEditing) {
      final hasChanges =
          title != widget.card!.title ||
          description != widget.card!.description;
      if (!hasChanges) {
        context.pop();
        return;
      }
      cardsProvider.editCard(
        widget.index!,
        title: title,
        description: description,
      );
    } else {
      cardsProvider.addCard(title, description);
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final defaultTitle = _isEditing ? 'Editar tarjeta' : 'Nueva tarjeta';

    return Scaffold(
      appBar: AppBar(title: Text(defaultTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBody(
            titleController: _titleController,
            descriptionController: _descriptionController,
            onSave: _handleSave,
          ),
        ),
      ),
    );
  }
}
