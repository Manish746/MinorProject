import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key key,
    this.iconPath,
    this.icon,
  }) : super(key: key);

  final String iconPath;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: icon == null
          ? SvgPicture.asset(
              iconPath,
              height: getProportionateScreenHeight(18),
            )
          : Icon(
              icon,
              size: getProportionateScreenHeight(18),
            ),
    );
  }
}
