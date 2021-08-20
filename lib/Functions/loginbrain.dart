import 'package:get_it/get_it.dart';
import 'package:driver_salary/Functions/authentication_models.dart';
import 'package:driver_salary/authentication_service.dart';

Future<void> startServices(String token) async {
  GetIt.I.reset();
  GetIt.I
      .registerLazySingleton(() => AuthenticationClient.create(token: token));
}

String message = 'Please enter a valid email';
dynamic validateEmail(String value) {
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]'
      r'+(\.[^<>()[\]\\.,;:\s@\"]+'
      r')*)|(\".+\"))@((\[[0-9]{1,3}\'
      r'.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]'
      r'{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return message;
  } else {
    return true;
  }
}
