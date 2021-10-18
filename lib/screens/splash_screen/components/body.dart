import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zarees/components/custom_loader.dart';
import 'package:zarees/models/app_model.dart';
import 'package:zarees/screens/home/home_screen.dart';
import 'package:zarees/screens/splash_screen/components/onboard.dart';
import 'package:zarees/utils/sharedPrefs.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // String token = "";

  @override
  void initState() {
    // token = StorageUtil.getString(kUserToken);
    String _isFirst = StorageUtil.getString(AppModel.isFirst);
    // print("token $token");
    super.initState();
    Timer(
      Duration(seconds: 1),
      () {
        // if (token != null && token.isNotEmpty) {
        //   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        // } else {
        //   Navigator.pushReplacementNamed(context, OnBoard.routeName);
        // }
        if (_isFirst != null &&
            _isFirst.isNotEmpty &&
            _isFirst.toLowerCase() == "true") {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          Navigator.pushReplacementNamed(context, OnBoard.routeName);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kDarkBlue,
        image: DecorationImage(
          image: AssetImage("assets/logo/zlogo.png"),
          fit: BoxFit.contain,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SpinKitFadingCircle(
              color: Colors.green,
              //shape: BoxShape.circle,
            ),
          ],
        ),
      ),
    );
  }
}
