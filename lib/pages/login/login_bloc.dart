import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_movies_udemy/pages/home/home_page.dart';
import 'package:flutter_movies_udemy/pages/login/login_api.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _progressController = BehaviorSubject<bool>();

  get progressStream => _progressController.stream;

  login(LoginInput input) async {
    _progressController.sink.add(true);

    try {
      return await LoginApi.login(input);

    } finally {
      _progressController.sink.add(false);
    }
  }

  close() {
    _progressController.close();
  }
}
