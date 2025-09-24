import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fase_1/domain/entities/info_card.dart';
import 'package:fase_1/presentation/providers/cards_provider.dart';

enum FormResult { created, updated }

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
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool _isSubmitting = false;

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

  Future<void> _handleSave() async {
    final form = _formKey.currentState;
    if (form == null) return;

    if (!form.validate()) {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
      _showSnackBar(
        message: 'Revisa los campos resaltados antes de continuar.',
        isError: true,
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _isSubmitting = true;
    });

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final cardsProvider = context.read<CardsProvider>();

    final bool success;
    late final FormResult outcome;

    if (_isEditing) {
      final originalCard = widget.args.card!;
      final hasChanges =
          title != originalCard.title ||
          description != originalCard.description;

      if (!hasChanges) {
        setState(() {
          _isSubmitting = false;
        });
        _showSnackBar(message: 'No se detectaron cambios para guardar.');
        context.pop();
        return;
      }

      success = cardsProvider.updateExistingCard(
        widget.args.index!,
        title: title,
        description: description,
      );
      outcome = FormResult.updated;
    } else {
      success = cardsProvider.addNewCard(
        title: title,
        description: description,
      );
      outcome = FormResult.created;
    }

    setState(() {
      _isSubmitting = false;
    });

    if (!success) {
      _showSnackBar(
        message: 'No fue posible guardar la tarjeta. Intenta nuevamente.',
        isError: true,
      );
      return;
    }

    context.pop(outcome);
  }

  void _showSnackBar({required String message, bool isError = false}) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTitle = _isEditing ? 'Editar tarjeta' : 'Nueva tarjeta';

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(defaultTitle),
        elevation: 0,
        scrolledUnderElevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEditing
                    ? 'Actualiza el contenido para mantener tu biblioteca al día.'
                    : 'Crea una nueva tarjeta con información relevante y atractiva.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: theme.colorScheme.primary.withValues(alpha: 0.15),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _FormSectionLabel(text: 'Título'),
                        TextFormField(
                          controller: _titleController,
                          textInputAction: TextInputAction.next,
                          maxLength: 50,
                          decoration: _inputDecoration(
                            context,
                            hint: 'Introduce un título memorable',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'El título es obligatorio.';
                            }
                            if (value.trim().length < 4) {
                              return 'Utiliza al menos 4 caracteres.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        _FormSectionLabel(text: 'Descripción'),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: _inputDecoration(
                            context,
                            hint:
                                'Describe la tarjeta con detalles inspiradores',
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          maxLines: 6,
                          maxLength: 280,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Agrega una descripción para contextualizar la tarjeta.';
                            }
                            if (value.trim().length < 10) {
                              return 'Amplía un poco más la descripción (mínimo 10 caracteres).';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _isSubmitting
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : FilledButton.icon(
                                  key: const ValueKey('save_button'),
                                  onPressed: _handleSave,
                                  icon: const Icon(Icons.save_rounded),
                                  label: Text(
                                    _isEditing
                                        ? 'Guardar cambios'
                                        : 'Crear tarjeta',
                                  ),
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String hint,
  }) {
    final theme = Theme.of(context);
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.3,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.colorScheme.error, width: 1.6),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: theme.colorScheme.error, width: 1.6),
      ),
      counterText: '',
      hintStyle: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
      ),
    );
  }
}

class _FormSectionLabel extends StatelessWidget {
  const _FormSectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
