import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  final String title;

  const LoginScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}