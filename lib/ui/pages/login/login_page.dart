import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class EmptyLoginPresenter implements LoginPresenter {
  @override
  void validateEmail(String value) {
    // TODO: implement validadeEmail
  }

  const EmptyLoginPresenter();

  @override
  void validatePassword(String value) {
    // TODO: implement validatePassword
  }

  @override
  // TODO: implement emailErrorStream
  Stream<String> get emailErrorStream => throw UnimplementedError();

  @override
  // TODO: implement passwordErrorStream
  Stream<String> get passwordErrorStream => throw UnimplementedError();

  @override
  // TODO: implement isFormValidStream
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  void auth() {
    // TODO: implement auth
  }

  @override
  // TODO: implement isLoadingStream
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  // TODO: implement mainErrorStream
  Stream<String> get mainErrorStream => throw UnimplementedError();

  @override
  void dispose() {
    // TODO: implement dispose
  }
}

class LoginPage extends StatefulWidget {
  final LoginPresenter _presenter;

  const LoginPage({Key? key, LoginPresenter? presenter})
      : _presenter = presenter ?? const EmptyLoginPresenter(),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        widget._presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Aguarde...', textAlign: TextAlign.center)
                      ],
                    )
                  ],
                );
              },
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }
        });

        widget._presenter.mainErrorStream.listen((error) {
          if (error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[900],
                content: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        });

        return SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const HeadLineLogin(),
            // const Spacer(),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    //email
                    StreamBuilder<String>(
                        stream: widget._presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              icon: const Icon(Icons.email),
                              errorText: snapshot.data?.isNotEmpty == true
                                  ? snapshot.data
                                  : null,
                            ),
                            autocorrect: false,
                            onChanged: widget._presenter.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          );
                        }),
                    //password
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: StreamBuilder<String>(
                          stream: widget._presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Senha',
                                  icon: const Icon(Icons.password),
                                  errorText: snapshot.data?.isNotEmpty == true
                                      ? snapshot.data
                                      : null),
                              autocorrect: false,
                              obscureText: true,
                              onChanged: widget._presenter.validatePassword,
                            );
                          }),
                    ),
                    StreamBuilder<bool>(
                        stream: widget._presenter.isFormValidStream,
                        builder: (context, snapshot) {
                          return ElevatedButton.icon(
                            onPressed: snapshot.data == true
                                ? widget._presenter.auth
                                : null,
                            icon: const Icon(Icons.login),
                            label: const Text('Entrar'),
                          );
                        }),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: Text('Criar conta'.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
            // const Spacer(),
          ],
        ));
      }),
    );
  }

  @override
  void dispose() {
    widget._presenter.dispose();
    super.dispose();
  }
}
