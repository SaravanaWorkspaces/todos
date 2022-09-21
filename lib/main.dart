import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todos/router_settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO',
      onGenerateRoute: RouterSettings.generateRoute,
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _launchScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.blue[400],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _loadLogo(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "TODO",
            style: TextStyle(
                fontSize: 46.0,
                color: Colors.white,
                decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }

  _launchScreen() async {
    await Future.delayed(const Duration(milliseconds: 2500), () {});
    Navigator.popAndPushNamed(context, RouterSettings.HOME_SCREEN);
  }

  _loadLogo() {
    return Image.asset(
            "assets/images/ic_checkbox_marked_circle_plus_outline_grey600_24dp.png",
            color: Colors.white,
            fit: BoxFit.fill,
            height: 150,
            width: 150,
          );
  }
}


  

