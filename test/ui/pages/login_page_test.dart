import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Should load with correct initial state', (tester) async {
    const loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(
      of: find.bySemanticsLabel('E-mail'),
      matching: find.byType(Text),
    );

    expect(
      emailTextChildren,
      findsOneWidget,
      reason:
          'Testa se o componente tem apenas um Text filho, ou seja, não está exibindo a mensagem de erro.',
    );

    final passwordTextChildren = find.descendant(
      of: find.bySemanticsLabel('Senha'),
      matching: find.byType(Text),
    );

    expect(
      passwordTextChildren,
      findsOneWidget,
      reason:
          'Testa se o componente tem apenas um Text filho, ou seja, não está exibindo a mensagem de erro.',
    );

    final button =
        tester.widget<ElevatedButton>(find.bySubtype<ElevatedButton>());
    expect(button.onPressed, null);
  });
}
