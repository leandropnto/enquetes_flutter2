import 'package:enquetes/ui/pages/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.read(loginPresenterProvider);

    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton.icon(
          onPressed: snapshot.data == true ? presenter.auth : null,
          icon: const Icon(Icons.login),
          label: const Text('Entrar'),
        );
      },
    );
  }
}
