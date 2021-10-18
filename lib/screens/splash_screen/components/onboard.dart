import 'package:flutter/material.dart';
import 'package:zarees/components/default_button.dart';
import 'package:zarees/models/app_model.dart';
import 'package:zarees/screens/home/home_screen.dart';
import 'package:zarees/screens/sign_in/sign_in_screen.dart';
import 'package:zarees/utils/sharedPrefs.dart';
import '../../../size_config.dart';
import 'build_dot.dart';
import 'splash_content.dart';

class OnBoard extends StatefulWidget {
  static const String routeName = "/onboard-screen";
  const OnBoard({Key key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int _currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Zarees, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {
      "text": "We help people connect with store \naround the world",
      "image": "assets/images/splash_2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (pageNumber) =>
                      setState(() => _currentPage = pageNumber),
                  itemCount: splashData.length,
                  itemBuilder: (ctx, index) => SplashContent(
                    text: splashData[index]['text'],
                    image: splashData[index]['image'],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length,
                          (index) => BuildDot(
                              pageNumber: index, currentPage: _currentPage)),
                    ),
                    Spacer(flex: 4),
                    Padding(
                      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                      child: DefaultButton(
                        text: "Continue",
                        press: () {
                          StorageUtil.setString(AppModel.isFirst, "True");
                          // Navigator.pushReplacementNamed(
                          //     context, SignInScreen.routeName);
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        },
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
