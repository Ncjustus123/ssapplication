import 'Functions/app_prefs.dart';
import 'Pilot_page/LogIn.dart';
import 'Pilot_page/report.dart';
import 'authentication_service.dart';
import 'inventory_page/welcome_page.dart';

import 'Functions/utilities.dart';
import 'provider/stock_request.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';
import 'provider/service_request.dart';

RemoteConfig _config;
int userType = 0;
bool hasLogged = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preInstance = await AppPreference.getInstance();
  hasLogged = preInstance.isLoggedIn() ?? false;
  if (hasLogged) {
    userType = preInstance.getUseDetails().userType ?? 0;

    GetIt.I.registerLazySingleton(() => AuthenticationClient.create());
  }

  runApp(MyApp());

  // This helps log all that go through http services
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  // startServices();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ServiceRequestProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => StockRequestProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Libmot Self Service',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        builder: EasyLoading.init(),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
        home: FutureBuilder(
          future: setupRemoteConfig(),
          builder:
              (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
            print(snapshot.hasData);
            return snapshot.hasData &&
                (snapshot.connectionState == ConnectionState.done)
                ? Provider(
              remote: snapshot.data,
              child: Builder(builder: (context) {
                Future.delayed(Duration(milliseconds: 500),
                        () => checkConfig(context));
                return (hasLogged)
                    ? (userType == 4)
                    ? Report()
                    : WelcomePage()
                    : LogIn();
              }),
            )
                : Container(
              color: Colors.red[900],
              child: Center(
                  child: Text('hghjcccy')),
            );
          },
        ),
      ),
    );
  }
}

class Provider extends InheritedWidget {
  final RemoteConfig remote;
  final Map appConfig = {};

  Provider({
    Key key,
    Widget child,
    this.remote,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider);
}

Future<bool> checkConfig(BuildContext context) async {
  RemoteConfig config = Provider.of(context).remote;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  print("version is $version");
  if (Theme.of(context).platform == TargetPlatform.android) {
    String currentVersion = config.getString("current_android_version");
    bool isMandatory = config.getBool("android_update_mandatory");
    if (!config.getBool("android_active")) {
      if (Provider.of(context).appConfig['showingPopUP'] ?? false) {
        return false;
      }
    }
    if (!isUserAppCurrent(version, currentVersion)) {
      // show dialog
      print("current status $isMandatory");
      showAndroidUpdateDialog(context, isMandatory);
    }
  }
  return true;
}

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: Duration(seconds: 0),
  ));
  try {
    await remoteConfig.notifyListeners();
    remoteConfig.setDefaults(<String, dynamic>{
      'current_android_version': '1.0.0',
      'android_active': true,
      'android_update_mandatory': true,
    });
    print(remoteConfig.getBool("android_active"));
    return remoteConfig;
  } catch (e) {
    return null;
  }
}

bool isUserAppCurrent(String deviceVersion, String firebaseVersion) {
  List deviceList = deviceVersion.split(".");
  List firebaseList = firebaseVersion.split(".");

  var unionLength = firebaseList.length > deviceList.length
      ? firebaseList.length
      : deviceList.length;

  for (var i = 0; i < unionLength; i++) {
    if (deviceList.length - 1 < i) {
      return false;
    }
    if (firebaseList.length - 1 < i) {
      return true;
    }
    if (int.parse(firebaseList[i]) > int.parse(deviceList[i])) {
      return false;
    }
    if (int.parse(firebaseList[i]) == int.parse(deviceList[i]) &&
        i == unionLength - 1) {
      return true;
    }
  }
  return false;
}

void showAndroidUpdateDialog(BuildContext context, bool mandatory) {
  showDialog(
      context: context,
      barrierDismissible: !mandatory,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return !mandatory;
          },
          child: AlertDialog(
            contentPadding:
            const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
            title: Text("New Version Available"),
            content: Text(
                "Your version of Libmot Self Service app is currently outdated, Please visit android store to get the latest version"),
            actions: <Widget>[
              (mandatory)
                  ? Container()
                  : FlatButton(
                child: Text("Later"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),

              FlatButton(
                child: Text("Update Now"),
                onPressed: () {
                  StoreRedirect.redirect(
                      androidAppId: SystemProperties.appPackageAndroid,
                      iOSAppId: SystemProperties.appIDIOS);
                },
              ),
            ],
          ),
        );
      });
}

void showLoading(
    {@required Color progressColor,
      Color backgroundColor,
      Color indicatorColor,
      Color textColor,
      EasyLoadingIndicatorType indicatorType,
      status}) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1000)
    ..indicatorType = indicatorType
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = progressColor
    ..backgroundColor = backgroundColor
    ..indicatorColor = indicatorColor
    ..textColor = textColor
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  EasyLoading.show(status: status);
}
