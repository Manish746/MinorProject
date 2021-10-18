import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zarees/constants.dart';
import './theme.dart';
import './routes.dart';

import './screens/splash_screen/splash_screen.dart';
import 'utils/hive_init.dart';
import 'utils/sharedPrefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  StorageUtil.initialiseToken();
  await hiveInitializing();
  print("token is " + StorageUtil.getString(kUserToken));
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zarees',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
