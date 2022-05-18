import 'package:enquetes/ui/pages/login/riverpod_login_presenter.dart';
import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginPresenterProvider =
    Provider<LoginPresenter>((_) => const RiverPodLoginPresenter());
