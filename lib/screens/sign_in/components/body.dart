import 'package:flutter/material.dart';
import 'package:zarees/constants.dart';

import './sign_in_form.dart';
import '../../../size_config.dart';
import '../../../components/no_account_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.16),
                Text(
                  "Welcome Back",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Sign in with your email and password.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.16),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                //SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
