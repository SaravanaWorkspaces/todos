import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[400],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              "assets/images/ic_checkbox_marked_circle_plus_outline_grey600_24dp.png",
              color: Colors.white),
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
}
