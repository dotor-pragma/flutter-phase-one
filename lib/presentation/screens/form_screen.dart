import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  static const String routeName = 'form_screen';
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Hello World from FormScreen')),
    );
  }
}
