import 'package:flutter/material.dart';
import '../../../models/Cart_Local_Model.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key key,
    @required this.cartItem,
    @required this.decrementCounter,
    @required this.incrementCounter,
  }) : super(key: key);

  final LocalCartModel cartItem;
  final decrementCounter, incrementCounter;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 0),
              ),
            ]),
        child: Row(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(88),
              child: AspectRatio(
                aspectRatio: .88,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/logo/zlogo.png",
                    image: cartItem.imageUrl,
                  ),
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cartItem.pName}",
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: '\₹${cartItem.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kPrimaryColor,
                      ),
                      // children: [
                      //   TextSpan(
                      //     text: ' x${widget.cartItem.numOfItem}',
                      //     style: TextStyle(color: kTextColor),
                      //   ),
                      // ],
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(
            //   flex: 2,
            // ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    color: cartItem.numOfItem < 2
                        ? Colors.grey
                        : Colors.red.shade700.withOpacity(0.6),
                    onPressed: cartItem.numOfItem < 2
                        ? () {}
                        : () {
                            decrementCounter();
                          },
                    icon: Icon(Icons.remove_circle_outline_outlined),
                    iconSize: 28,
                  ),
                  Text("${cartItem.numOfItem}"),
                  IconButton(
                    color: Colors.greenAccent.shade700,
                    onPressed: () {
                      incrementCounter();
                    },
                    iconSize: 28,
                    icon: Icon(Icons.add_circle_outline_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
