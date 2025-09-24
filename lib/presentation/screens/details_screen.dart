import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = 'details_screen';
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Hello World from DetailsScreen')),
    );
  }
}
