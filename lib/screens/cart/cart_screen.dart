import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:zarees/constants.dart';
import 'package:zarees/controllers/local_cart_controller.dart';
import 'package:zarees/main.dart';
import 'package:zarees/models/Cart_Local_Model.dart';
import 'package:zarees/utils/sharedPrefs.dart';

import '../../size_config.dart';
import '../../models/Cart.dart';
import './components/custom_bottom_navigation_bar.dart';
import 'components/cart_item_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "My Cart",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade600,
              ),
            ),
          ],
        ),
      ),
      body: StorageUtil.getString(kUserToken).isEmpty
          ? CartBody()
          : UserCartBody(),
      bottomNavigationBar: CustomCartBottomNavigationBar(),
    );
  }
}

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalCartController>(context, listen: true);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
      child: ListView.builder(
        itemCount: hiveCartBox.length,
        itemBuilder: (ctx, index) {
          var _hKey = hiveCartBox.keyAt(index);
          return Padding(
            padding:
                EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10)),
            child: Dismissible(
              key: Key(hiveCartBox.keyAt(index)),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) {
                return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Delete this item\n from Cart?",
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        Navigator.pop(context, true);
                                      },
                                      child: Text(
                                        "Remove",
                                        style: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Colors.lightBlue.shade200,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.white60,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              onDismissed: (direction) {
                provider.removeItem(_hKey);
                // hiveCartBox.delete(_hKey);
                // setState(() {});
              },
              background: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFFE5E5),
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartItemCard(
                cartItem: hiveCartBox.get(_hKey),
                decrementCounter: () {
                  provider.decrementItem(_hKey);
                },
                incrementCounter: () {
                  provider.incrementItem(_hKey);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

//  Container(
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15)),
//     child: CartItemCard(cartItem: hiveCartBox.getAt(index))),

// child: Dismissible(
//   key: Key(hiveCartBox.keyAt(index)),
//   direction: DismissDirection.endToStart,
//   onDismissed: (direction) {
//     hiveCartBox.delete(key);
//   },
//   background: Container(
//     decoration: BoxDecoration(
//         color: Color(0xFFFFE5E5),
//         borderRadius: BorderRadius.circular(15)),
//     padding: EdgeInsets.symmetric(horizontal: 20),
//     child: Row(
//       children: [
//         Spacer(),
//         SvgPicture.asset("assets/icons/Trash.svg"),
//       ],
//     ),
//   ),
//   child: CartItemCard(
//     cartItem: hiveCartBox.get(key),
//   ),
// ),

// class CartBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: ListView.builder(
//         itemCount: demoCarts.length,
//         itemBuilder: (ctx, index) => Padding(
//           padding:
//               EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10)),
//           child: Dismissible(
//             key: Key(demoCarts[index].product.id.toString()),
//             direction: DismissDirection.endToStart,
//             onDismissed: (direction) {
//               demoCarts.removeAt(index);
//             },
//             background: Container(
//               decoration: BoxDecoration(
//                   color: Color(0xFFFFE5E5),
//                   borderRadius: BorderRadius.circular(15)),
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   Spacer(),
//                   SvgPicture.asset("assets/icons/Trash.svg"),
//                 ],
//               ),
//             ),
//             child: CartItemCard(
//               cartItem: demoCarts[index],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class UserCartBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: demoCarts.length,
        itemBuilder: (ctx, index) => Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenWidth(10)),
          child: Dismissible(
            key: Key(demoCarts[index].product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              demoCarts.removeAt(index);
            },
            background: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFFFE5E5),
                  borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: Container(),
            // child: CartItemCard(
            //   cartItem: demoCarts[index],
            // ),
          ),
        ),
      ),
    );
  }
}
