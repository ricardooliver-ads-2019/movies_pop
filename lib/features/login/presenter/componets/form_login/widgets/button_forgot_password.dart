import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonForgotPassword extends StatelessWidget {
  const ButtonForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse('https://www.themoviedb.org/reset-password'));
      },
      child: const Text(
        'Esqueci minha senha',
        style: TextStyle(
          color: Color.fromARGB(255, 80, 70, 70),
          decoration: TextDecoration.underline,
          decorationColor: Color.fromARGB(255, 223, 95, 86),
        ),
      ),
    );
  }
}
