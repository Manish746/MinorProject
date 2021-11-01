import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zarees/constants.dart';
import './theme.dart';
import './routes.dart';

import './screens/splash_screen/splash_screen.dart';
import 'controllers/local_cart_controller.dart';
import 'utils/hive_init.dart';
import 'utils/sharedPrefs.dart';

Box hiveCartBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  StorageUtil.initialiseToken();
  hiveCartBox = await hiveInitializing();
  print("token is " + StorageUtil.getString(kUserToken));
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalCartController(),
        ),
      ],
      child: MyApp(),
    ),
  );
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
