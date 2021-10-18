import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zarees/screens/categories/categories.dart';
import 'package:zarees/screens/home/home_screen.dart';
//import 'package:zarees/screens/home/home_screen.dart';
import 'package:zarees/screens/profile/profile_screen.dart';
import 'package:zarees/size_config.dart';
import 'package:zarees/utils/sharedPrefs.dart';

import '../constants.dart';

enum Menu { home, categories, profile }

class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final Menu selectedMenu;
  final Color inActiveColor = Color(0xFFADADAD);
  final Color activeColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        //color: Colors.deepPurple,
        color: kDarkBlue,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, -10),
            // color: Color(0xFFDADADA).withOpacity(.40),
            color: Colors.amber.withOpacity(0.1),
          ),
          BoxShadow(
            blurRadius: 3,
            offset: Offset(0, 0),
            // color: Color(0xFFDADADA).withOpacity(.40),
            color: Colors.amber.withOpacity(0.6),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: selectedMenu == Menu.home ? 1.4 : 1,
                  child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/Shop Icon.svg",
                        color: selectedMenu == Menu.home
                            ? activeColor
                            : inActiveColor,
                      ),
                      onPressed: () {
                        selectedMenu == Menu.home
                            ? null
                            : Navigator.pushReplacementNamed(
                                context, HomeScreen.routeName);
                      }),
                ),
                selectedMenu == Menu.home
                    ? Text(
                        "Home",
                        style: TextStyle(color: activeColor),
                      )
                    : Container(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: selectedMenu == Menu.categories ? 1.4 : 1,
                  child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/categories.svg",
                        height: getProportionateScreenHeight(20),
                        color: selectedMenu == Menu.categories
                            ? activeColor
                            : inActiveColor,
                      ),
                      onPressed: () {
                        selectedMenu == Menu.categories
                            ? null
                            : Navigator.pushReplacementNamed(
                                context, CategoryScreen.routeName);
                      }),
                ),
                selectedMenu == Menu.categories
                    ? Text(
                        "Categories",
                        style: TextStyle(color: activeColor),
                      )
                    : Container(),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: selectedMenu == Menu.profile ? 1.4 : 1,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: SvgPicture.asset(
                        "assets/icons/User Icon.svg",
                        height: getProportionateScreenHeight(20),
                        color: selectedMenu == Menu.profile
                            ? activeColor
                            : inActiveColor,
                      ),
                      onPressed: () {
                        selectedMenu == Menu.profile
                            ? null
                            : Navigator.pushReplacementNamed(
                                context, ProfileScreen.routeName);
                      }),
                ),
                selectedMenu == Menu.profile
                    ? Transform.scale(
                        scale: 1,
                        child: Text(
                          "Profile",
                          style: TextStyle(color: activeColor),
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
