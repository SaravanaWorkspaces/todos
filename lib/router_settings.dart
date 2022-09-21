import 'package:todos/main.dart';
import 'package:flutter/material.dart';
import 'package:todos/home/home_screen.dart';
import 'package:todos/todo/add_edit_todo.dart';

class RouterSettings {
  static const String ROUTE = "/";
  static const String HOME_SCREEN = "/home";
  static const String ADD_EDIT_TODO = "/add-edit-todo";
  static const String ADD_EDIT_PURCHASE = "/add-edit-purchase";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE:
        return MaterialPageRoute(builder: ((_) => const SplashScreen()));
      case HOME_SCREEN:
        return MaterialPageRoute(builder: ((_) => const HomeScreen()));
      case ADD_EDIT_TODO:
        return MaterialPageRoute(builder: ((_) => const AddEditTodoScreen()));
      default:
        return MaterialPageRoute(
          builder: ((_) => Scaffold(
                body: Center(
                  child: Text("No route defined for ${settings.name}"),
                ),
              )),
        );
    }
  }
}
