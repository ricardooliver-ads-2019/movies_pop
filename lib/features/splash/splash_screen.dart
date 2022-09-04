import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _filmAnimationController;
  late AnimationController _logoAnimationController;
  late Animation<double> _degrees;
  late Animation<double> _position;
  late Animation<double> _opacity;
  late Animation<double> _size;

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _degrees = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(
          parent: _logoAnimationController,
          curve: const Interval(0.5, 1, curve: Curves.easeInOutBack)),
    );

    _filmAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _position = Tween<double>(begin: -400, end: 0).animate(
      CurvedAnimation(
        parent: _filmAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _filmAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    _size = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _filmAnimationController.forward();

    _filmAnimationController.addStatusListener(runLogoAnimation);

    _logoAnimationController.addStatusListener(navigationToMyPage);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getItDependency.get<AuthSession>().init();
    });
  }

  void navigationToMyPage(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (getItDependency.get<AuthSession>().sessionId == null ||
          getItDependency.get<AuthSession>().id == null ||
          getItDependency.get<AuthSession>().username == null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.mainNavigationPage);
      }
    }
  }

  void runLogoAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _logoAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _filmAnimationController.dispose();
    _logoAnimationController.removeStatusListener(navigationToMyPage);
    _filmAnimationController.removeStatusListener(runLogoAnimation);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _filmAnimationController,
            builder: (context, _) {
              return Transform.translate(
                offset: Offset(_position.value, 0),
                child: Center(
                  child: Opacity(
                    opacity: _opacity.value,
                    child: Image.asset(
                      'assets/images/images_splash/logoFilm.png',
                      width: 300,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ),
              );
            },
          ),
          Center(
            child: AnimatedBuilder(
              animation: _logoAnimationController,
              builder: (context, _) {
                return Container(
                  width: mediaSize.width * 0.50,
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: LogoPrincipal(
                    size: _size.value,
                    degrees: _degrees.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LogoPrincipal extends StatelessWidget {
  const LogoPrincipal({Key? key, required this.size, required this.degrees})
      : super(key: key);
  final double size;
  final double degrees;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: (pi / 180) * degrees,
          child: Center(
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(),
              child: Image.asset(
                'assets/images/images_splash/logoGreenTriangle.png',
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
        SizedBox(
          child: Center(
            child: Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(),
              child: Image.asset(
                'assets/images/images_splash/logoBlueTriangle.png',
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
