import 'package:flutter/material.dart';
import 'package:movies_pop/features/login/presenter/componets/form_login/login_credential.dart';

class FormLogin extends StatefulWidget {
  final ValueChanged<String> login;
  final ValueChanged<String> password;

  const FormLogin({
    Key? key,
    required this.login,
    required this.password,
  }) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin>
    with SingleTickerProviderStateMixin {
  final credential = LoginCredential();
  late final TextEditingController _texLoginController;
  late final TextEditingController _texPasswordController;
  bool isObscured = true;

  @override
  void initState() {
    _texLoginController = TextEditingController();
    _texPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _texLoginController.dispose();
    _texPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: _texLoginController,
          onChanged: widget.login,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            labelText: 'Login:',
            labelStyle: TextStyle(color: Colors.white),
            suffixIcon: Icon(Icons.person_outline),
          ),
        ),
        TextFormField(
          controller: _texPasswordController,
          onChanged: widget.password,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: isObscured,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  isObscured = !isObscured;
                  setState(() {});
                },
                icon: isObscured
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined)),
            labelText: 'Senha:',
            labelStyle: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
