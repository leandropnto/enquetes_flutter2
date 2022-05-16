import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '4Dev',
      home: LoginPage(),
    );
  }
}
