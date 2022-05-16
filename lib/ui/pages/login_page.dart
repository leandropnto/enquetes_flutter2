import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            child: Image.asset("lib/ui/assets/logo.png"),
          ),
          const Text('Login'),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //email
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      icon: Icon(Icons.email),
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  //password
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.password),
                    ),
                    autocorrect: false,
                    obscureText: true,
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
        ],
      )),
    );
  }
}
