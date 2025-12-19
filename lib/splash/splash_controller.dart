import 'package:culture_app1/pages/home_view.dart';
import 'package:flutter/material.dart';

time(BuildContext context) {
  Future.delayed(const Duration(seconds: 4), () {
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  });
}
