import 'package:enquetes/ui/helpers/extensions/theme_context.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: SizedBox(
        height: size,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const HeadLineLogin(),
            const Spacer(),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    //email
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        icon: Icon(
                          Icons.email,
                          color: context.theme.primaryColorLight,
                        ),
                      ),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    //password
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(
                            Icons.password,
                            color: context.theme.primaryColorLight,
                          ),
                        ),
                        autocorrect: false,
                        obscureText: true,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.login),
                      label: const Text('Entrar'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      label: Text('Criar conta'.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
