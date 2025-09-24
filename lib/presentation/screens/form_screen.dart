import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';

class FormScreenArgs {
  const FormScreenArgs.create() : card = null, index = null;

  const FormScreenArgs.edit({required this.card, required this.index});

  final InfoCard? card;
  final int? index;

  bool get isEditing => card != null && index != null;
}

class FormScreen extends StatefulWidget {
  static const String routeName = 'form_screen';

  const FormScreen({super.key, this.args = const FormScreenArgs.create()});

  final FormScreenArgs args;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  bool get _isEditing => widget.args.isEditing;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.args.card?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.args.card?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    FocusScope.of(context).unfocus();

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final cardsProvider = context.read<CardsProvider>();

    if (_isEditing) {
      final originalCard = widget.args.card!;
      final hasChanges =
          title != originalCard.title ||
          description != originalCard.description;
      if (!hasChanges) {
        context.pop();
        return;
      }
      cardsProvider.updateExistingCard(
        widget.args.index!,
        title: title,
        description: description,
      );
    } else {
      cardsProvider.addNewCard(title: title, description: description);
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
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _titleController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSave,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
