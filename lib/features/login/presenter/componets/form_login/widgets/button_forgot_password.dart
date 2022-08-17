import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ButtonForgotPassword extends StatelessWidget {
  const ButtonForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Link(
        uri: Uri.parse('https://www.themoviedb.org/reset-password'),
        target: LinkTarget.self,
        builder: (context, followLink) {
          return GestureDetector(
            onTap: followLink,
            child: const Text(
              'Esqueci minha senha',
              style: TextStyle(
                color: Color.fromARGB(255, 80, 70, 70),
                decoration: TextDecoration.underline,
                decorationColor: Color.fromARGB(255, 223, 95, 86),
              ),
            ),
          );
        });
  }
}
