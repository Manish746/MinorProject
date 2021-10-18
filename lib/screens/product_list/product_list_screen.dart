import 'package:flutter/material.dart';
import 'package:zarees/components/custom_bottom_navigation_bar.dart';
import 'package:zarees/components/product_card.dart';
import 'package:zarees/models/Product.dart';

import '../../constants.dart';
import '../../size_config.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key key}) : super(key: key);

  static const routeName = '/productList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kDarkBlue,
        leading: Container(),
        titleSpacing: 0,
        title: PhysicalModel(
          color: Colors.white,
          elevation: 2,
          child: Container(
            color: kDarkBlue,
            height: getProportionateScreenHeight(60),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10),
              ),
              child: Image.asset('assets/logo/zlogo.png'),
            ),
          ),
        ),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavigationBar(selectedMenu: Menu.home),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
          itemCount: productList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: getProportionateScreenWidth(10)),
          itemBuilder: (context, index) {
            return ProductCard(product: productList[index], press: () {});
          }),
    );
  }
}
