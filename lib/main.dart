import 'package:flutter/material.dart';
import 'package:test_app/provider/add_update_todo_provider.dart';
import 'package:test_app/provider/login_and_signup_provider.dart';
import 'package:test_app/provider/todo_list_item.dart';
import 'package:test_app/provider/user_global_variable_provider.dart';
import 'package:test_app/view/login/bloc/login_bloc.dart';
import 'package:test_app/view/login/login_view.dart';
import 'package:test_app/view/sign_up/bloc/signup_bloc.dart';
import 'package:test_app/view/todo/new_update_todo_item/bloc/add_new_todo_bloc.dart';
import 'package:test_app/view/todo/todo_view.dart';
import 'package:test_app/widget/config_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'file:///D:/music/test_app/lib/data_base/database_operation/todo_data_base_operation.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Widget screen=Container();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  print("sharedPreferences.getBool() ${sharedPreferences.getBool("loginDone")}");

  if (sharedPreferences.getBool("loginDone") == true) {
    screen=TodoView();
  }else screen=LoginView();
  runApp(MyApp(screen));
}

class MyApp extends StatelessWidget {
Widget screen;
MyApp(this.screen);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //AddNewTodoBloc
        BlocProvider<AddNewTodoBloc>(
          create: (context) => AddNewTodoBloc()..add(initTodoEvent()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc()..add(loginInit()),
        ),
        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc()..add(SignUpInitEvent()),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AddUpdateTodoProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoginAndSignupProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => TodoListItemProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserGlobalVariableProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(screen),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  Widget screen;
  MyHomePage(this.screen);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserGlobalVariableProvider globalVariableProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    globalVariableProvider =
        Provider.of<UserGlobalVariableProvider>(context, listen: false);
    initValues(context);

  }

  @override
  Widget build(BuildContext context) {
    ConfigScreen configScreen = ConfigScreen(context);

    WidgetSize widgetSize = WidgetSize(configScreen);

    return Scaffold(
      body: widget.screen,
    );
  }

   initValues(BuildContext context) async {

    UserGlobalVariableProvider globalVariableProvider = Provider.of<UserGlobalVariableProvider>(context, listen: false);

    TodoListItemProvider todoListItemProvider =  Provider.of<TodoListItemProvider>(context, listen: false);

    globalVariableProvider.setLoginIsDone(false);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    TodoDatabaseOperation myDataBase = TodoDatabaseOperation();

    await myDataBase.userInfoDatBase();

    var id = sharedPreferences.getInt("user_id");

    if (id != null && id >= 0) {

      globalVariableProvider.setUserIdValues(id);

      todoListItemProvider.todoListItem = await myDataBase.getAllPost("user_todo_info", id);
    }

  }
}
