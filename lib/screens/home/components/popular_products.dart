import 'package:flutter/material.dart';
import 'package:zarees/screens/product_list/product_list_screen.dart';

import './section_title.dart';
import '../../../size_config.dart';
import '../../../models/Product.dart';
import '../../../components/product_card.dart';
import '../../product_details/product_details_screen.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
            title: "Popular Products",
            press: () {
              Navigator.pushNamed(context, ProductListScreen.routeName);
            }),
        SizedBox(height: getProportionateScreenHeight(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                productList.length,
                (index) => ProductCard(
                  product: productList[index],
                  press: () => Navigator.pushNamed(
                    context,
                    ProductDetailsScreen.routeName,
                    arguments: productList[index],
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
