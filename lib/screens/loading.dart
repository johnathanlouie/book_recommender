import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String title;

  const LoadingScreen({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(title, style: Theme.of(context).textTheme.headline2)),
    );
  }
}
