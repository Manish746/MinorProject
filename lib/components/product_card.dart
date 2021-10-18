import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../size_config.dart';
import '../models/Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width = 140,
    this.aspectRatio = 1.02,
    @required this.product,
    @required this.press,
  }) : super(key: key);

  final Product product;
  final double width, aspectRatio;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kPrimaryLightColor,
      borderRadius: BorderRadius.circular(15),
      onTap: press,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
        child: Ink(
          decoration: BoxDecoration(
            // color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                      margin: EdgeInsets.only(
                        top: getProportionateScreenWidth(8),
                      ),
                      height: getProportionateScreenHeight(150),
                      width: getProportionateScreenWidth(150),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(
                            product.images[0],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${product.title}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(16),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                Text(
                  "\₹${product.price}",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Text(
                //     //   "\₹${product.price}",
                //     //   style: TextStyle(
                //     //     fontSize: getProportionateScreenWidth(18),
                //     //     fontWeight: FontWeight.bold,
                //     //     color: kPrimaryColor,
                //     //   ),
                //     // ),
                //     // InkWell(
                //     //   onTap: () {},
                //     //   borderRadius: BorderRadius.circular(30),
                //     //   child: Container(
                //     //     padding: EdgeInsets.all(getProportionateScreenWidth(6)),
                //     //     width: getProportionateScreenWidth(28),
                //     //     height: getProportionateScreenHeight(28),
                //     //     decoration: BoxDecoration(
                //     //       color: product.isFavourite
                //     //           ? kPrimaryColor.withOpacity(.17)
                //     //           : kSecondaryColor.withOpacity(.12),
                //     //       shape: BoxShape.circle,
                //     //     ),
                //     //     child: SvgPicture.asset(
                //     //       product.isFavourite
                //     //           ? "assets/icons/Heart Icon_2.svg"
                //     //           : "assets/icons/Heart Icon.svg",
                //     //       color: product.isFavourite
                //     //           ? Color(0xFFFF4848).withOpacity(.9)
                //     //           : Color(0xFFDBDEE4),
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
