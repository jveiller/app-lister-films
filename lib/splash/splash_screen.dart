import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    time(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 240, 105),
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: TailleAdaptateur.width(context, 230),
        ),
      ),
    );
  }
}
