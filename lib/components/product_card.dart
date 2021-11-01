import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';
import '../size_config.dart';
import '../models/Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key key,
      this.width = 140,
      this.aspectRatio = 1.02,
      @required this.product,
      @required this.press,
      this.color})
      : super(key: key);

  final Product product;
  final double width, aspectRatio;
  final GestureTapCallback press;
  final Color color;

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
            color: color ?? Colors.blueGrey.shade100,
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
                      //color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                          product.images[0],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Container(
                    width: getProportionateScreenWidth(150),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.title}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenHeight(16),
                                  fontWeight: FontWeight.w600,
                                ),
                                //  textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                // maxLines: 2,
                              ),
                              Text(
                                "\₹${product.price}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FaIcon(
                            FontAwesomeIcons.chevronCircleRight,
                            color: Colors.amber.shade400.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
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
