import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '4Dev',
      home: const LoginPage(),
      theme: makeAppTheme(),
    );
  }
}
