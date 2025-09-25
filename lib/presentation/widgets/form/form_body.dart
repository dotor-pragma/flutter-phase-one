import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onSave,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FormField(controller: titleController, labelText: 'Titulo'),
        const SizedBox(height: 16),
        _FormField(controller: descriptionController, labelText: 'Descripción'),
        const SizedBox(height: 24),
        _SaveButton(onPressed: onSave),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({required this.controller, required this.labelText});

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Guardar'),
      ),
    );
  }
}
