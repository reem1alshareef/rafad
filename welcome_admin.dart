import 'package:flutter/material.dart';
import 'package:rafad1/screens/splash_page.dart';

class welcomeadmin extends StatefulWidget {
  const welcomeadmin({Key? key}) : super(key: key);

  @override
  State<welcomeadmin> createState() => _welcomeadminState();
}

class _welcomeadminState extends State<welcomeadmin> {
  @override
  Widget build(BuildContext context) {
    return Splash();
  }
}
