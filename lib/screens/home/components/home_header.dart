import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zarees/constants.dart';
import 'package:zarees/controllers/local_cart_controller.dart';
import 'package:zarees/screens/cart/cart_screen.dart';
import 'package:zarees/utils/sharedPrefs.dart';

import './search_field.dart';
import '../../../size_config.dart';
import './icon_button_with_counter.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.white,
      elevation: 2,
      child: Container(
        color: kDarkBlue,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 5,
                child: Container(
                    height: getProportionateScreenHeight(60),
                    child: Image.asset('assets/logo/zlogo.png')),
              ),
              // SearchField(),
              IconButtonWithCounter(
                  svgSrc: 'assets/icons/Cart Icon.svg',
                  press: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                  noOfItems: StorageUtil.getString(kUserToken).isEmpty
                      ? Provider.of<LocalCartController>(context).cartLength
                      : 0 //Todo Cart Items when signed In,
                  ),
              // IconButtonWithCounter(
              //   svgSrc: 'assets/icons/Bell.svg',
              //   noOfItems: 3,
              //   press: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
