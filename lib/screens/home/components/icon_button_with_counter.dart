import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key key,
    @required this.svgSrc,
    this.noOfItems = 10,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int noOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(
              getProportionateScreenWidth(8),
            ),
            height: getProportionateScreenHeight(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(.01),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              svgSrc,
              color: Colors.lime,
              width: getProportionateScreenWidth(40),
            ),
          ),
          if (noOfItems != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: getProportionateScreenHeight(22),
                width: getProportionateScreenWidth(22),
                decoration: BoxDecoration(
                  color: Color(0xFF4848FF),
                  border: Border.all(width: 1, color: Colors.white),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$noOfItems",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(10),
                      height: getProportionateScreenHeight(1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}