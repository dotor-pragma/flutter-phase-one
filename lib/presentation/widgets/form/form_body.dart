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
        _TitleField(controller: titleController),
        const SizedBox(height: 16),
        _DescriptionField(controller: descriptionController),
        const SizedBox(height: 24),
        _SaveButton(onPressed: onSave),
      ],
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: const Text('Save')),
    );
  }
}
