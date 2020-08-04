import 'package:driver_salary/LogIn.dart';
import 'package:driver_salary/app_prefs.dart';
import 'package:driver_salary/authentication_service.dart';
import 'package:driver_salary/report.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

void main() {
  startServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: (!hasLogged) ? LogIn() : Report(),
    );
  }
}

bool hasLogged = false;

void startServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.getInstance().then((preInstance) {
    hasLogged = preInstance.isLoggedIn() ?? false;
    if (hasLogged) {
      GetIt.I.registerLazySingleton(() => AuthenticationClient.create());
    }
  });

  // This helps log all that go through http services
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
