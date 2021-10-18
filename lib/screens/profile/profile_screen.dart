import 'package:flutter/material.dart';
import 'package:zarees/constants.dart';
import 'package:zarees/screens/sign_in/sign_in_screen.dart';
import 'package:zarees/utils/sharedPrefs.dart';

import '../../size_config.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import 'profile_section_bar.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "/profile";

  final String _token = StorageUtil.getString(kUserToken);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: kDarkBlue,
      body: SafeArea(
          child: Column(children: [
        //Zaares Banner Code
        Card(
          margin: EdgeInsets.zero,
          color: kDarkBlue,
          child: AspectRatio(
            aspectRatio: 2,
            child: Image.asset(
              'assets/logo/zlogo.png',
              // color: kDarkBlue,
              //fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(40)),
        _token.isNotEmpty ? ProfileBody() : _buildSignInBody(context),
      ])),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.profile),
    );
  }
}

_buildSignInBody(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AspectRatio(
        aspectRatio: 1.5,
        child: Image.asset(
          'assets/images/signIn.png',
          //fit: BoxFit.contain,
        ),
      ),
      SizedBox(height: getProportionateScreenHeight(20)),
      Text(
        "Please Sign In To Continue",
        style: TextStyle(color: Colors.blueGrey),
      ),
      SizedBox(height: getProportionateScreenHeight(10)),
      TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7))),
          onPressed: () {
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
            child: Text(
              "Click here to Sign In",
              style: TextStyle(
                //   color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ))
    ],
  );
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: getProportionateScreenHeight(40)),

            //   SizedBox(height: getProportionateScreenHeight(60)),

            ProfileSectionButton(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () {},
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            ProfileSectionButton(
              text: "My Orders",
              icon: "assets/icons/Parcel.svg",
              press: () {},
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            ProfileSectionButton(
              text: "My Wishlist",
              icon: "assets/icons/Heart Icon.svg",
              press: () {},
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            ProfileSectionButton(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            ProfileSectionButton(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
