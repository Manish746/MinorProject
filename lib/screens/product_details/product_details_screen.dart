import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:provider/provider.dart';
import 'package:zarees/components/custom_loader.dart';
import 'package:zarees/components/rounded_icon_button.dart';
import 'package:zarees/controllers/local_cart_controller.dart';
import 'package:zarees/main.dart';
import 'package:zarees/models/Cart_Local_Model.dart';
import 'package:zarees/models/Product.dart';
import 'package:zarees/models/product/product_model.dart';
import 'package:zarees/screens/cart/cart_screen.dart';
import '../../constants.dart';
import '../../controllers/add_to_wishlist.dart';
import '../../screens/sign_in/sign_in_screen.dart';
import '../../utils/sharedPrefs.dart';
import '../../../components/custom_shimmer.dart';
import '../../../controllers/products/product_details.dart';
import '../../../models/product/single_product_model.dart';

import './components/custom_appbar.dart';

import '../../../size_config.dart';
import './components/product_images.dart';
import './components/product_description.dart';
import './components/top_rounded_container.dart';
import '../../components/default_button.dart';

List<String> _imageUrls = [
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/9140095/2019/4/1/f6934dba-622f-4cd8-80b2-3f2f26966d4e1554102654447-Mitera-Pink-Silk-Blned--Woven-Design-Party-wear-Banarasi-Sar-5.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2019/11/28/54bc693d-b8e9-4bd1-bcee-f29918cbbe651574893594096-4.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2021/6/26/92d6f741-0ae8-4bfd-938d-090f59cad1081624684557360-4.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/15751306/2021/10/6/caf230c4-36de-4d0e-9733-db99dc95a0561633517385414UnnatiSilksWomenBlueWovenDesign3.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/15553374/2021/9/21/73ed6234-16ed-4860-b7d5-704d25bd0a8e1632226349642TheChennaiSilksWomenBlueWovenDesign5.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/15192404/2021/8/18/951196ad-3699-403f-afff-3733c8296abc1629306154713PisaraWomenRedPrinted3.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2020/1/29/80540821-c258-4be7-b726-288f9281a0601580249433911-5.jpg",
  "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2019/8/11/377767df-b98e-4326-9ac3-65a6443384451565465392479-5.jpg",
];

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-details';
  final String pId;
  ProductDetailsScreen({@required this.pId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future<SingleProductModel> _product;

  @override
  void initState() {
    _product = ProductDetailsController().getProductDetails(widget.pId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xFFF5F6F9),
      backgroundColor: Colors.white,
      //appBar: CustomAppBar(4),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.blueGrey.shade200,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _product,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ProductBody(product: snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Snap!! Some Error Occurred!!"),
            );
          } else {
            return customShimmer(size);
          }
        },
      ),
    );
  }
}

class ProductBody extends StatefulWidget {
  final SingleProductModel product;

  const ProductBody({Key key, this.product}) : super(key: key);

  @override
  _ProductBodyState createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  //bool isFav = product.isfavourite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              ProductImages(
                imageUrls: _imageUrls,
              ),
              Container(
                //decoration: BoxDecoration(color: Color(0xFFF5F6F9)),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade200,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenWidth(10)),
                  child: TopRoundedContainer(
                    color: Colors.white,
                    child: ProductDescription(
                      product: widget.product,
                      pressOnSeeMore: () {},
                      onFavTap: () async {
                        if (StorageUtil.getString(kUserToken).isNotEmpty) {
                          try {
                            var data = AddToWishListController.toJson(
                                widget.product.product.id);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomLoader();
                                });
                            bool _success = await AddToWishListController()
                                .addToWishList(data)
                                .timeout(
                                  Duration(milliseconds: 5000),
                                );
                            Navigator.of(context).pop();
                            if (_success) {
                              setState(() {
                                widget.product.isfavourite =
                                    !widget.product.isfavourite;
                                print("${widget.product.isfavourite}");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        content: Text("Wishlist updated!!")));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  content: Text(
                                      "Wishlist couldn't be updated!! Try Again."),
                                ),
                              );
                            }
                          } on TimeoutException catch (_) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                content: Text("Couldn't update the wishlist!!"),
                              ),
                            );
                            //rethrow;
                          } on Exception catch (_) {
                            // Show a dialog or something
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                content: Text("Some Error occured!!"),
                              ),
                            );
                            //rethrow;
                          }
                        } else {
                          _showLoginDialog(context);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * .25,
              right: SizeConfig.screenWidth * .25,
              top: getProportionateScreenWidth(10),
              bottom: getProportionateScreenWidth(20),
            ),
            child: _buildAddtoCartButton(),
          ),
        ),
      ],
    );
  }

  Widget _buildAddtoCartButton() {
    if (StorageUtil.getString(kUserToken).isNotEmpty) {
      print(widget.product.inCart);
      if (widget.product.inCart) {
        return DefaultButton(
          color: Colors.lightGreenAccent.shade700.withGreen(180),
          text: "Go to Cart 🛒",
          press: () {
            Navigator.pushNamed(
              context,
              CartScreen.routeName,
            );
          },
        );
      } else {
        return DefaultButton(
            text: "Add to Cart",
            press: () {
              print("NONE");
              setState(() {
                widget.product.inCart = true;
              });
            });
      }
    } else {
      //Todo Insert and Check into Hive Database
      //?For adding product in cart
      final provider = Provider.of<LocalCartController>(context, listen: true);
      print("Checking");
      if (provider.inCart(widget.product.product.id)) {
        return DefaultButton(
          color: Colors.lightGreenAccent.shade700.withGreen(180),
          text: "Go to Cart 🛒",
          press: () {
            Navigator.pushNamed(
              context,
              CartScreen.routeName,
            );
          },
        );
      } else {
        return DefaultButton(
            text: "Add to Cart",
            press: () {
              print("ALL NONE");
              provider.addProductToCart(
                product: widget.product,
                imageUrls: _imageUrls,
              );
            });
      }
    }
  }

  Future<dynamic> _showLoginDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kDarkBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            titlePadding: EdgeInsets.all(2),
            insetPadding: EdgeInsets.all(2),
            buttonPadding: EdgeInsets.all(2),
            actionsPadding: EdgeInsets.all(2),
            title: Text(
              "Kindly Login to\n Add to Wishlist.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            content: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SignInScreen.routeName,
                );
              },
            ),
          );
        });
  }
}
