import 'package:flutter/material.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  final List<Widget> categoryList = [
    SizedBox(height: getProportionateScreenHeight(40)),
    CategoryCard(
        image: "assets/category/Banarasi.jpg", text: "Banarasi", press: () {}),
    SizedBox(height: getProportionateScreenHeight(40)),
    CategoryCard(
        image: "assets/category/cotton.jpg", text: "Cotton", press: () {}),
    SizedBox(height: getProportionateScreenHeight(40)),
    CategoryCard(
        image: "assets/category/handwoven.jpg",
        text: "Handwoven",
        press: () {}),
    SizedBox(height: getProportionateScreenHeight(40)),
    CategoryCard(image: "assets/category/silk.jpg", text: "Silk", press: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: categoryList,
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    // @required this.noOfBrands,
    @required this.image,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  //final int noOfBrands;
  final String image, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Container(
        height: getProportionateScreenHeight(150),
        width: double.maxFinite,
        child: InkWell(
          onTap: press,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "$text\n",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
