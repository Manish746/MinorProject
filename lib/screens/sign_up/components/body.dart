import 'package:flutter/material.dart';

import '../../../constants.dart';
import './sign_up_form.dart';
import '../../../size_config.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "Register Account",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Complete your details and\ntake a leap with us",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                SignUpForm(),
                //SizedBox(height: SizeConfig.screenHeight * 0.06),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "By continuing you confirm that you agree\nwith our terms and conditions",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
