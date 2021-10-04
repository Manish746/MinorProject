import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flybuy/controllers/otp_generate_and_verify.dart';
import 'package:flybuy/screens/sign_in/sign_in_screen.dart';
import 'package:flybuy/utils/countdownTimer.dart';
import '../../constants.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp-screen';
  OtpScreen({@required this.email});
  final email;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';
  OTPCountDown _otpCountDown;
  bool canResend = false;
  String time = "";
  void enterValue(String s) {
    if (otp.length < 6) {
      setState(() {
        otp = otp + s;
      });
      if (otp.length == 6) {
        //Call the method
        onSubmit(otp, context);
        print('$otp');
      }
    }
  }

  void onSubmit(value, context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SpinKitSpinningCircle(
          color: Colors.white,
        );
      },
    );

    print("${widget.email} + $value");
    String json =
        OtpGenerateAndVerify.toJsonOtp(email: widget.email, otp: value);
    Response _response = await OtpGenerateAndVerify.otpVerify(
      json: json,
      errorText: "Verify Otp",
    );

    if (_response != null) {
      if (_response.statusCode != 200) {
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                child: AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.priority_high_rounded,
                        color: Colors.red,
                      ),
                      Text(
                        'Error',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Kindly enter the correct OTP"),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                ),
              );
            });
        setState(() {
          otp = '';
        });
        print('Error Occured! Please Try again');
      } else {
        Navigator.pop(context);
        if (_response.data['emailVerified']) {
          Navigator.pushReplacementNamed(
            context,
            SignInScreen.routeName,
          );
        } else {
          setState(() {
            otp = '';
          });
          print('try Again later');
        }
      }
    } else {
      setState(() {
        otp = '';
      });
      Navigator.pop(context);
    }
  }

  void _startCountdown() {
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: 1000 * 6 * 30, // time in milliseconds
      currentCountDown: (String countDown) {
        // shows current count down time
        setState(() {
          time = countDown;
        });
      },
      onFinish: () {
        setState(() {
          canResend = true;
        });
        print("Count down finished!"); // called when the count down finishes.
      },
    );
  }

  void clearValue() {
    if (otp.isNotEmpty) {
      setState(() {
        int index = otp.length - 1;
        otp = otp.substring(0, index);
        print(otp);
      });
    }
  }

  @override
  void initState() {
    _startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    _otpCountDown.cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kDarkBlue,
          // gradient: kPrimaryGradientColor,
        ),
        child: SafeArea(
          child: Column(
            //   alignment: Alignment.topCenter,
            children: [
              Spacer(),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        "Verify With OTP",
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text(
                    'Enter 6 digit code sent to your mail id',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OtpTextBox(
                          size: size,
                          text: otp.length > 0 ? otp[0] : "",
                        ),
                        OtpTextBox(
                          size: size,
                          text: otp.length > 1 ? otp[1] : "",
                        ),
                        OtpTextBox(
                          size: size,
                          text: otp.length > 2 ? otp[2] : "",
                        ),
                        OtpTextBox(
                          size: size,
                          text: otp.length > 3 ? otp[3] : "",
                        ),
                        OtpTextBox(
                          size: size,
                          text: otp.length > 4 ? otp[4] : "",
                        ),
                        OtpTextBox(
                          size: size,
                          text: otp.length > 5 ? otp[5] : "",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get a code? ",
                        style: TextStyle(
                          color: Colors.lightGreen.shade100,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          "RESEND",
                          style: TextStyle(
                            color: canResend
                                ? Colors.deepOrange.shade100
                                : Colors.black45,
                            fontWeight:
                                canResend ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        onPressed: !canResend
                            ? null
                            : () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return SpinKitFadingCube(
                                      color: Colors.white,
                                    );
                                  },
                                );
                                String json = OtpGenerateAndVerify.toJsonOtp(
                                    email: widget.email);
                                Response _response =
                                    await OtpGenerateAndVerify.otpGenerate(
                                  json: json,
                                  errorText: "Generate Otp",
                                );
                                if (_response != null) {
                                  if (_response.statusCode != 200) {
                                    Navigator.pop(context);
                                    print('Error Occured! Please Try again');
                                  } else {
                                    print("True");
                                    Navigator.pop(context);
                                    setState(() {
                                      canResend = false;
                                      otp = "";
                                      _startCountdown();
                                    });
                                  }
                                } else {
                                  Navigator.pop(context);
                                  print("Response is null in generate otp");
                                }
                              },
                      ),
                      Visibility(
                        visible: !canResend,
                        child: Text(time),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              _buildNumberRow(size),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildNumberRow(Size size) {
    return Container(
      // color: kPrimaryLightColor,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: '1',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('1');
                },
              ),
              CustomButton(
                text: '2',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('2');
                },
              ),
              CustomButton(
                text: '3',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('3');
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: '4',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('4');
                },
              ),
              CustomButton(
                text: '5',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('5');
                },
              ),
              CustomButton(
                text: '6',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('6');
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: '7',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('7');
                },
              ),
              CustomButton(
                text: '8',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('8');
                },
              ),
              CustomButton(
                text: '9',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('9');
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: '',
                onTapFunctionCallback: null,
                size: size,
              ),
              CustomButton(
                text: '0',
                size: size,
                onTapFunctionCallback: () {
                  enterValue('0');
                },
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  //   splashColor: Colors.red[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  clearValue();
                },
                icon: Icon(
                  Icons.backspace_outlined,
                  //color: Colors,
                  color: Colors.white,
                  size: size.width * 0.1,
                ),
                label: Text(""),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OtpTextBox extends StatelessWidget {
  const OtpTextBox({
    Key key,
    @required this.size,
    @required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.1,
      decoration: BoxDecoration(
          color: Color(0xffFBD4AC).withOpacity(0.7),
          //color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black54,
            width: 0.7,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 2.0,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size.width * 0.1,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTapFunctionCallback;
  final TextStyle textStyle;
  final size;
  const CustomButton({
    @required this.text,
    @required this.onTapFunctionCallback,
    this.textStyle,
    @required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: CircleBorder(),
        //  highlightColor: Colors.grey,
        //splashColor: kDarkBlue.withOpacity(0.7),
      ),
      onPressed: onTapFunctionCallback,
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              fontSize: size.width * 0.1,
              //color: Color(0xff434343),
              color: kPrimaryLightColor,
            ),
      ),
    );
  }
}

getSnackBar(String text) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(
        fontSize: 20,
      ),
    ),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
  );
}
