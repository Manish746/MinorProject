import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flybuy/screens/categories/categories.dart';
import 'package:flybuy/screens/home/home_screen.dart';
//import 'package:flybuy/screens/home/home_screen.dart';
import 'package:flybuy/screens/profile/profile_screen.dart';
import 'package:flybuy/size_config.dart';
import 'package:flybuy/utils/sharedPrefs.dart';

import '../constants.dart';

enum Menu { home, categories, profile }

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final Menu selectedMenu;
  final Color inActiveColor = Color(0xFFADADAD);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, -15),
            color: Color(0xFFDADADA).withOpacity(.40),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color:
                      selectedMenu == Menu.home ? kPrimaryColor : inActiveColor,
                ),
                onPressed: () {
                  selectedMenu == Menu.home
                      ? null
                      : Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                }),
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/categories.svg",
                  height: getProportionateScreenHeight(20),
                  color: selectedMenu == Menu.categories
                      ? kPrimaryColor
                      : inActiveColor,
                ),
                onPressed: () {
                  selectedMenu == Menu.categories
                      ? null
                      : Navigator.pushReplacementNamed(
                          context, CategoryScreen.routeName);
                }),
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: selectedMenu == Menu.profile
                      ? kPrimaryColor
                      : inActiveColor,
                ),
                onPressed: () {
                  selectedMenu == Menu.profile
                      ? null
                      : Navigator.pushReplacementNamed(
                          context, ProfileScreen.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
