import 'dart:async';

import 'package:enquetes/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter = LoginPresenterSpy();
  late StreamController<String> emailErrorController;
  late StreamController<String> passwordErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;
  late StreamController<String> mainErrorController;

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
  });

  Future<void> loadPage(WidgetTester tester) async {
    emailErrorController = StreamController();
    passwordErrorController = StreamController();
    isFormValidController = StreamController();
    isLoadingController = StreamController();
    mainErrorController = StreamController();

    when(() => presenter.emailErrorStream)
        .thenAnswer((invocation) => emailErrorController.stream);

    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);

    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);

    when(() => presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Should load with correct initial state', (tester) async {
    await loadPage(tester);

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

  testWidgets('Should call validate with correct values', (tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('E-mail'), email);

    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);

    verify(() => presenter.validatePassword(password));
  });

  testWidgets('Should present error if email is invalid', (tester) async {
    await loadPage(tester);
    emailErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (tester) async {
    await loadPage(tester);
    emailErrorController.add('');
    await tester.pump();

    expect(
      find.descendant(
        of: find.bySemanticsLabel('E-mail'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should present error if password is invalid', (tester) async {
    await loadPage(tester);
    passwordErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);
  });

  testWidgets('Should present no error if password is valid', (tester) async {
    await loadPage(tester);
    passwordErrorController.add('');
    await tester.pump();

    expect(
      find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Should enable button if form is valid', (tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button =
        tester.widget<ElevatedButton>(find.bySubtype<ElevatedButton>());
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid', (tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button =
        tester.widget<ElevatedButton>(find.bySubtype<ElevatedButton>());
    expect(button.onPressed, isNull);
  });

  testWidgets('Should call authentication on form submit', (tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = find.bySubtype<ElevatedButton>();
    await tester.ensureVisible(button);
    await tester.tap(button);

    await tester.pump();
    verify(() => presenter.auth()).called(1);
  });

  testWidgets('Should present loading', (tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should present error message if authentication fails',
      (tester) async {
    await loadPage(tester);

    mainErrorController.add('Main Error');
    await tester.pump();

    expect(find.text('Main Error'), findsOneWidget);
  });

  testWidgets('Should close streams on dispose', (tester) async {
    await loadPage(tester);
    await tester.pump();
    addTearDown(() {
      verify(() => presenter.dispose()).called(13);
    });
  });
}
