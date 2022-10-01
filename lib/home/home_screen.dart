import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/purchase/purchase_list_screen.dart';
import 'package:todos/router_settings.dart';
import 'package:todos/todo/bloc/todo_bloc.dart';
import 'package:todos/todo/bloc/todo_state.dart';
import 'package:todos/todo/todo_list_screen.dart';
import 'package:todos/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.TODO),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: Constants.TODO_TAB_TITLE),
              Tab(text: Constants.PURCHASE_TAB_TITLE),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_tabController.index == 0) {
              Navigator.pushNamed(context, RouterSettings.ADD_EDIT_TODO).then((value) => setState(() {}));
            } else {
              Navigator.pushNamed(context, RouterSettings.ADD_EDIT_PURCHASE);
            }
          },
          child: const Icon(Icons.add),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<TodoBloc>(
              create: (context) => TodoBloc(AddTodoInitial()),
            )
          ],
          child: TabBarView(
            controller: _tabController,
            children: [TodoListScreen(), PurchaseListScreen()],
          ),
        ));
  }
}
