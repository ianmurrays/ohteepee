import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './redux/app_actions.dart';
import './redux/app_state.dart';
import './redux/app_middleware.dart';
import './redux/app_reducer.dart';
import './screens/add_password.dart';
import './screens/camera.dart';
import './screens/edit_password.dart';
import './screens/home/home_screen.dart';
import './providers/global_timer.dart';
import './storage/database.dart';
import './models/password.dart';

class OhTeePee extends StatefulWidget {
  @override
  _OhTeePeeState createState() => _OhTeePeeState();
}

class _OhTeePeeState extends State<OhTeePee> {
  Store<AppState> store;
  final Database db = Database();

  @override
  void initState() {
    super.initState();

    store = Store<AppState>(
      appReducer,
      initialState: AppState.init(),
      middleware: createStoreMiddleware(db.passwordDao),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_ctx) => GlobalTimer(),
      child: StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Oh Tee Pee',
          theme: _lightTheme(),
          darkTheme: _darkTheme(),
          themeMode: ThemeMode.system,
          routes: {
            '/': (_ctx) {
              store.dispatch(LoadPasswords());

              return HomeScreen();
            },
          },
        ),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.blueGrey,
      backgroundColor: Colors.grey[850],
      dialogBackgroundColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.grey[850],
      textTheme: ThemeData.dark().textTheme,
      accentColor: Colors.blueGrey[300],
      selectedRowColor: Colors.grey[900],
      hintColor: Colors.white,
      canvasColor: Colors.grey[850],
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.grey[300],
        ),
        helperStyle: TextStyle(
          color: Colors.grey[300],
        ),
        hintStyle: TextStyle(
          color: Colors.grey[300],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[300],
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[300],
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red[900],
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red[900],
          ),
        ),
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: Colors.blueGrey,
      accentColor: Colors.blueGrey[800],
      selectedRowColor: Colors.blueGrey[50],
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: Colors.blueGrey[800],
        ),
        helperStyle: TextStyle(
          color: Colors.blueGrey[800],
        ),
        hintStyle: TextStyle(
          color: Colors.blueGrey[800],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blueGrey[800],
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blueGrey[800],
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red[900],
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red[900],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    db.close();

    super.dispose();
  }
}
