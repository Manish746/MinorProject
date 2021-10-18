import 'package:flutter/material.dart';

import './section_title.dart';
import '../../../size_config.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Special for you",
          press: () {},
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/category/Banarasi.jpg",
                text: "Banarsi",
                // noOfBrands: 10,
                press: () {},
              ),
              SpecialOfferCard(
                image: "assets/category/handwoven.jpg",
                text: "Handwoven",
                // noOfBrands: 15,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    //  @required this.noOfBrands,
    @required this.image,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  // final int noOfBrands;
  final String image, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          height: getProportionateScreenHeight(100),
          width: getProportionateScreenWidth(242),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              )),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "  $text\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    backgroundColor: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
