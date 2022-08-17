import 'package:flutter/material.dart';

class ButtonLogin extends StatefulWidget {
  String login, password;
  final ValueNotifier animationErro;
  final VoidCallback functionLogin;
  ButtonLogin({
    Key? key,
    required this.animationErro,
    required this.password,
    required this.login,
    required this.functionLogin,
  }) : super(key: key);

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> animationContainerWidth;
  late final Animation<double> animationContainerRadius;
  late final Animation<double> animationOpacityText;
  late final Animation<double> animationOpacityProgress;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animationController.addListener(() {
      if (_animationController.value == 1.0) {
        widget.functionLogin();
      }
      setState(() {});
    });

    animationContainerWidth =
        Tween<double>(begin: 100, end: 50).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
      reverseCurve: Curves.easeOut,
    ));
    animationContainerRadius =
        Tween<double>(begin: 10, end: 50).animate(_animationController);

    animationOpacityProgress =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.39, 1),
    ));

    animationOpacityText =
        Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0, 0.39),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    if (widget.animationErro.value) {
      _animationController.reverse();
      loading = false;
      widget.animationErro.value = false;
    }
    return GestureDetector(
      child: Container(
        width: animationContainerWidth.value,
        height: mediaSize.height * 0.05,
        constraints: const BoxConstraints(minHeight: 50, maxHeight: 70),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(144, 206, 161, 100),
              Color.fromRGBO(60, 190, 201, 100),
              Color.fromRGBO(0, 179, 229, 100),
            ],
            stops: [
              0.0,
              0.3,
              0.5,
            ],
          ),
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(animationContainerRadius.value),
        ),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Opacity(
                opacity: animationOpacityProgress.value,
                child: const CircularProgressIndicator(),
              ),
              Opacity(
                opacity: animationOpacityText.value,
                child: const Text(
                  'Logar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        setState(() {});
        print('clik');
        _animationController.forward();
        if (widget.password.isNotEmpty && widget.login.isNotEmpty) {
          _animationController.forward();
          loading = true;
        } else {
          String message = 'Os campos não pode ser vazios';
          if (widget.login.isEmpty && widget.password.isNotEmpty) {
            message = 'Login não pode ser vazio';
          }
          if (widget.password.isEmpty && widget.login.isNotEmpty) {
            message = 'Campo senha não pode ser vazio';
          }
          _animationController.reverse();
          var snackBar = SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
