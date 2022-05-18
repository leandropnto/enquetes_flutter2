import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter _presenter;

  const LoginPage({Key? key, required LoginPresenter presenter})
      : _presenter = presenter,
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
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        widget._presenter.mainErrorStream.listen(
          (error) {
            if (error.isNotEmpty) {
              showErrorMessage(context, error);
            }
          },
        );

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
                    const EmailInput(),
                    //password
                    const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 32),
                      child: PasswordInput(),
                    ),
                    const LoginButton(),
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
