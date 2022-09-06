import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pop/core/routes/app_routes.dart';
import 'package:movies_pop/features/login/presenter/componets/form_login/button_login.dart';
import 'package:movies_pop/features/login/presenter/componets/form_login/form_login.dart';
import 'package:movies_pop/features/login/presenter/componets/form_login/widgets/button_create_account.dart';
import 'package:movies_pop/features/login/presenter/componets/form_login/widgets/button_forgot_password.dart';
import 'package:movies_pop/features/login/presenter/controller/login_cubit_controller.dart';
import 'package:movies_pop/features/login/presenter/controller/login_state.dart';
import 'package:movies_pop/features/login/presenter/widgets/logo.dart';
import 'package:movies_pop/features/shared/widgets/snackBar/snackBar_sistem.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animationPosition;
  late Animation<double> animationOpacity;

  late LoginCubitController _controller;

  var animationErro = ValueNotifier(false);
  late RenderBox? renderBox;
  String login = '';
  String password = '';

  @override
  void didChangeDependencies() {
    animationPosition = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    animationOpacity = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = context.read<LoginCubitController>();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    initAnimated();
  }

  Future<void> initAnimated() async {
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubitController, LoginState>(
        listener: (context, state) async {
      if (state is Error) {
        animationErro.value = true;
        final message = state.error.message?.toString() ?? 'Error';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarSistem().snackBarErrorGeneric(message),
        );
      }
      if (state is LoginSuccess) {
        await _animationController.forward();

        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.mainNavigationPage);

        await _animationController.reverse();
      }
    }, builder: (context, state) {
      return Scaffold(
          body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black87,
                    Colors.blue,
                    Colors.white,
                  ],
                  stops: [
                    0.01,
                    0.5,
                    0.9,
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 800, minHeight: 550),
                  width: mediaSize.width,
                  height: mediaSize.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Logo(),
                        const SizedBox(
                          height: 20,
                        ),
                        FormLogin(
                          login: (value) {
                            setState(() {
                              login = value;
                            });
                          },
                          password: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ButtonLogin(
                              functionLogin: () {
                                _controller.validateTokenWithLoginUsecase(
                                  login: login,
                                  password: password,
                                );
                              },
                              animationErro: animationErro,
                              login: login,
                              password: password,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const ButtonForgotPassword(),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const ButtonCreateAccount()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) {
                    return Container(
                      width: 0,
                      height: 0,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black87,
                          Colors.blue,
                          Colors.white,
                        ],
                        stops: [
                          0.01,
                          0.5,
                          0.9,
                        ],
                      )),
                    );
                  }),
            )
          ],
        ),
      ));
    });
  }
}
