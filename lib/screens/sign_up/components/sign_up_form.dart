import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flybuy/components/custom_loader.dart';
import 'package:flybuy/controllers/otp_generate_and_verify.dart';
import 'package:flybuy/controllers/signup_controller.dart';
import 'package:flybuy/screens/otp/otp_screens.dart';
import 'package:flybuy/screens/sign_in/sign_in_screen.dart';
//import 'package:flybuy/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_suffix_icon.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email, password, confirmPassword, fullName, contactNumber;
  final List<String> errors = [];
  bool firstSubmit = false;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          _buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          _buildContactFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          _buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          _buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(35)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return CustomLoader();
                  },
                );
                SignUpData user = SignUpData(
                  name: fullName,
                  contactNumber: contactNumber,
                  email: email,
                  password: password,
                );

                var _response = await user.sendData();
                setState(() {});

                if (_response != "OK") {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${_response.toUpperCase()}'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  String json = OtpGenerateAndVerify.toJsonOtp(email: email);
                  Response _response = await OtpGenerateAndVerify.otpGenerate(
                    json: json,
                    errorText: "Generate Otp",
                  );
                  Navigator.pop(context);
                  if (_response != null) {
                    if (_response.statusCode != 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${_response.data?.toUpperCase()}'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                      print('Error Occured! Please Try again');
                    } else {
                      print("True");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OtpScreen(email: email);
                      }));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Something Went Wrong'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pushReplacementNamed(
                        context, SignInScreen.routeName);
                    print("Response is null in generate otp");
                  }
                }
              }
              //_formKey.currentState.save();
              // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
            },

            // firstSubmit = true;
            // },
          ),
        ],
      ),
    );
  }

  TextFormField _buildNameFormField() {
    return TextFormField(
      onSaved: (newName) => this.fullName = newName,
      onChanged: (fullName) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (fullName) {
        if (fullName.isEmpty) {
          return kNameError;
        } else if (fullName.isNotEmpty &&
            fullName.contains(RegExp(r'[a-zA-Z]'))) {
          return null;
        }

        return kInvalidNameError;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        suffixIcon: CustomSuffixIcon(
          icon: Icons.person_outline_sharp,
        ),
      ),
    );
  }

  TextFormField _buildContactFormField() {
    return TextFormField(
      onSaved: (newNum) => this.contactNumber = newNum,
      onChanged: (contactNumber) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (newNumber) {
        if (newNumber.isEmpty) {
          return kPhoneNumberNullError;
        } else if (newNumber.isNotEmpty &&
            !phoneValidatorRegExp.hasMatch(newNumber)) {
          return kInvalidNumberError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Contact number",
        hintText: "Enter your Contact Number",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Phone.svg"),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  TextFormField _buildEmailFormField() {
    return TextFormField(
      onSaved: (newEmail) => this.email = newEmail,
      onChanged: (email) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (email) {
        if (email.isEmpty) {
          return kEmailNullError;
        } else if (email.isNotEmpty && !emailValidatorRegExp.hasMatch(email)) {
          return kInvalidEmailError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Mail.svg"),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  TextFormField _buildPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => this.password = newPassword,
      onChanged: (password) {
        if (firstSubmit) _formKey.currentState.validate();
        this.password = password;
      },
      validator: (password) {
        if (password.isEmpty) {
          return kPassNullError;
        } else if (password.isNotEmpty && password.length <= 7) {
          return kShortPassError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }

  TextFormField _buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newPassword) => this.confirmPassword = newPassword,
      onChanged: (password) {
        if (firstSubmit) _formKey.currentState.validate();
      },
      validator: (password) {
        if (password != this.password) {
          return kMatchPassError;
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Repeat your password",
        suffixIcon: CustomSuffixIcon(iconPath: "assets/icons/Lock.svg"),
      ),
      obscureText: true,
    );
  }
}
