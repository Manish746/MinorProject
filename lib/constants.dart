import 'package:flutter/material.dart';
import './size_config.dart';

const kPrimaryColor = Color(0xFF6776FF);
const kPrimaryLightColor = Color(0xFFDFECFF);
const kDarkBlue = Color(0xff162A46);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF3EA5FF), Color(0xFF4376FF)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidatorRegExp = RegExp(r"^[6-9]\d{9}$");
const String kEmailNullError = "Please Enter your email";
const String kNameError = "Please Enter Name";
const String kInvalidNameError = "Please Enter Valid Name";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kInvalidNumberError = "Please Enter Valid Mobile Number";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short, at least 8 chars";
const String kMatchPassError = "Passwords don't match";
const String kFirstNamelNullError = "Please Enter your first name";
const String kLastNamelNullError = "Please Enter your last name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

const String kUserToken = 'token';
const String kUserId = 'userId';
const String kUserName = 'fullname';
const String kUserEmail = 'email';
const String kUserContact = 'contact';

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
