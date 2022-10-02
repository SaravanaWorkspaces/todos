import 'package:todos/main.dart';
import 'package:flutter/material.dart';
import 'package:todos/home/home_screen.dart';
import 'package:todos/todo/add_edit_todo_screen.dart';
import 'package:todos/todo/todo_detail_screen.dart';

class RouterSettings {
  static const String ROUTE = "/";
  static const String HOME_SCREEN = "/home";
  static const String ADD_EDIT_TODO = "/add-edit-todo";
  static const String ADD_EDIT_PURCHASE = "/add-edit-purchase";
  static const String VIEW_TODO = "/view-todo";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ROUTE:
        return MaterialPageRoute(builder: ((_) => const SplashScreen()));
      case HOME_SCREEN:
        return MaterialPageRoute(builder: ((_) => const HomeScreen()));
      case ADD_EDIT_TODO:
        int? todoId;
        if (args != null) {
          todoId = (args as int);
        }
        return MaterialPageRoute(
            builder: ((_) => AddEditTodoScreen(todoId: todoId)));
      case VIEW_TODO:
        int? todoId;
        if (args != null) {
          todoId = (args as int);
        }
        return MaterialPageRoute(
            builder: ((_) => TodoDetailScreen(todoId: todoId!)));
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
