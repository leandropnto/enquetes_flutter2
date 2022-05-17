import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      icon: Icon(
                        Icons.email,
                      ),
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  //password
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(
                          Icons.password,
                        ),
                      ),
                      autocorrect: false,
                      obscureText: true,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: null,
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
          // const Spacer(),
        ],
      )),
    );
  }
}
