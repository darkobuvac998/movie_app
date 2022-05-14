import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/movie.dart';
import 'providers/movies.dart';
import 'screens/base_screen.dart';
import 'screens/show_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Movies(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Movie(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.copyWith(
                headline5: TextStyle(
                  fontFamily: 'IMFellFrenchCanonSC',
                  color: Colors.grey.shade300,
                  fontSize: 20,
                ),
                headline4: TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.grey.shade100,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
          fontFamily: 'Oswald',
          scaffoldBackgroundColor: Colors.grey.shade900,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
          ),
          primaryTextTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey,
          ).copyWith(
            secondary: Colors.black87,
            brightness: Brightness.dark,
          ),
        ),
        home: const BaseScreen(),
        routes: {
          ShowDetailScreen.routName: (context) => ShowDetailScreen(),
        },
      ),
    );
  }
}
