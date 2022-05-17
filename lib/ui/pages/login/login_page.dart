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
}

class LoginPage extends StatelessWidget {
  final LoginPresenter _presenter;

  const LoginPage({Key? key, LoginPresenter? presenter})
      : _presenter = presenter ?? const EmptyLoginPresenter(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      stream: _presenter.emailErrorStream,
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
                          onChanged: _presenter.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        );
                      }),
                  //password
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: StreamBuilder<String>(
                        stream: _presenter.passwordErrorStream,
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
                            onChanged: _presenter.validatePassword,
                          );
                        }),
                  ),
                  StreamBuilder<bool>(
                      stream: _presenter.isFormValidStream,
                      builder: (context, snapshot) {
                        return ElevatedButton.icon(
                          onPressed: snapshot.data == true ? () {} : null,
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
      )),
    );
  }
}
