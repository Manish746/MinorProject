import 'package:flutter/material.dart';
import 'package:zarees/screens/categories/categories.dart';
import 'package:zarees/screens/product_list/product_list_screen.dart';
import 'package:zarees/screens/splash_screen/components/body.dart';

import './screens/cart/cart_screen.dart';
import './screens/home/home_screen.dart';
import './screens/sign_in/sign_in_screen.dart';
import './screens/sign_up/sign_up_screen.dart';
import './screens/profile/profile_screen.dart';
import './screens/splash_screen/splash_screen.dart';
import './screens/forgot_password/forgot_password_screen.dart';
//import './screens/complete_profile/complete_profile_screen.dart';
import './screens/product_details/product_details_screen.dart';
import 'screens/splash_screen/components/onboard.dart';

Map<String, WidgetBuilder> routes = {
  OnBoard.routeName: (ctx) => OnBoard(),
  ProductListScreen.routeName: (ctx) => ProductListScreen(),
  CategoryScreen.routeName: (ctx) => CategoryScreen(),
  CartScreen.routeName: (ctx) => CartScreen(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  SplashScreen.routeName: (ctx) => SplashScreen(),
  SignInScreen.routeName: (ctx) => SignInScreen(),
  SignUpScreen.routeName: (ctx) => SignUpScreen(),
  ProfileScreen.routeName: (ctx) => ProfileScreen(),
  ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
  ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
  // CompleteProfileScreen.routeName: (ctx) => CompleteProfileScreen(),
};
