import 'package:enquetes/ui/pages/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordInput extends ConsumerWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presenter = ref.read(loginPresenterProvider);

    return StreamBuilder<String>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
              labelText: 'Senha',
              icon: const Icon(Icons.password),
              errorText:
                  snapshot.data?.isNotEmpty == true ? snapshot.data : null),
          autocorrect: false,
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      },
    );
  }
}
