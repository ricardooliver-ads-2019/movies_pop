import 'package:flutter/material.dart';
import 'package:movies_pop/core/auth/auth.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getItDependency.get<AuthSession>().init();

      if (getItDependency.get<AuthSession>().sessionId == null ||
          getItDependency.get<AuthSession>().id == null ||
          getItDependency.get<AuthSession>().username == null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.mainNavigationPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPLASH'),
      ),
      body: Container(
        color: Colors.red,
        child: const Center(
          child: SizedBox(
              height: 40, width: 40, child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
