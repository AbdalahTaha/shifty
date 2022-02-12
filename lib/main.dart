import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'package:provider/provider.dart';
import './providers/shift.dart';
import 'package:realm/realm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Shifts(),
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          // primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
