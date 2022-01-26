import 'package:flutter/material.dart';
import 'package:flutter_authentification/screens/home_screens.dart';
import 'package:flutter_authentification/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "app",
      home: HomeScreen(),
    );
  }
}
