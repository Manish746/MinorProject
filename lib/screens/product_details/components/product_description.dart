import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zarees/models/product/product_model.dart';
import '../../../models/product/single_product_model.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    @required this.pressOnSeeMore,
    @required this.onFavTap,
  }) : super(key: key);

  final SingleProductModel product;
  final GestureTapCallback pressOnSeeMore;
  final GestureTapCallback onFavTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            product.product.productName,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10),
              ),
              child: Text(
                "₹${product.product.price}",
                style: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onFavTap,
                child: Container(
                  width: getProportionateScreenWidth(64),
                  padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                  decoration: BoxDecoration(
                    color: product.isfavourite
                        ? kPrimaryColor.withOpacity(.37)
                        : kSecondaryColor.withOpacity(.12),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: SvgPicture.asset(
                    product.isfavourite
                        ? "assets/icons/Heart Icon_2.svg"
                        : "assets/icons/Heart Icon.svg",
                    color: product.isfavourite
                        ? Color(0xFFFF4848).withOpacity(.9)
                        : Colors.blueGrey.shade300,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateScreenWidth(18),
              top: getProportionateScreenHeight(5)),
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: Colors.purple.shade600,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "Category :- ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    product.product.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "Size :- ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    product.product.size
                        .toString()
                        .substring(product.product.size.toString().length - 1),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  product.product.description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(
        //     bottom: 5,
        //     left: getProportionateScreenWidth(20),
        //     right: getProportionateScreenWidth(20),
        //   ),
        //   child: SizedBox(
        //     child: TextButton(
        //       onPressed: pressOnSeeMore,
        //       child: Row(
        //         children: [
        //           Text("See More Details"),
        //           SizedBox(width: 5),
        //           Icon(Icons.arrow_forward_ios, size: 12),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
