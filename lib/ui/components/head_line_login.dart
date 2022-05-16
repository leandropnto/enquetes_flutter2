import 'package:enquetes/ui/helpers/extensions/theme_context.dart';
import 'package:flutter/material.dart';

class HeadLineLogin extends StatelessWidget {
  const HeadLineLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'LOGIN',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headline1,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Informe os dados de acesso e clique em "Entrar"',
          style: context.theme.textTheme.subtitle2,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
