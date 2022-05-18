import 'package:enquetes/ui/pages/login/provider/login_provider.dart';
import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_theme.dart';

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final loginPresenter = ref.watch(loginPresenterProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '4Dev',
      home: LoginPage(presenter: loginPresenter),
      theme: makeAppTheme(),
    );
  }
}
