import 'package:flutter/material.dart';

import '../../size_config.dart';
import './components/body.dart';
import '../../components/custom_bottom_navigation_bar.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "/category";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavigationBar(selectedMenu: Menu.categories),
    );
  }
}
