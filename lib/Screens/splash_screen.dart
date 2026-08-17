import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  final String title;

  const SplashScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}