import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:zarees/controllers/products/product_details.dart';
import 'package:zarees/models/Product.dart';
import 'package:zarees/screens/product_details/product_details_screen.dart';
import '../../apiConstant.dart';
import '../../components/custom_bottom_navigation_bar.dart';
import '../../components/custom_shimmer.dart';
import '../../controllers/products/product_list.dart';
import '../../models/product/product_list_model.dart';

import '../../constants.dart';
import '../../size_config.dart';

enum Price { low, high, any }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key key}) : super(key: key);

  static const routeName = '/productList';

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  showDialogBox(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            child: Text("Hello"),
          ),
        );
      },
    );
  }

  //For category
  String _api = APIs.productAll + "";

  Future<ProductListModel> pListModel;

  Price _sort = Price.any;

  ProductListModel sortProduct(ProductListModel _productListModel) {
    if (_sort == Price.low) {
      _productListModel.productList.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sort == Price.high) {
      _productListModel.productList.sort((a, b) => b.price.compareTo(a.price));
    } else {
      _productListModel.productList.shuffle();
    }
    return _productListModel;
  }

  @override
  void initState() {
    // TODO: implement initState
    print(_api);
    pListModel = ProductListController().getProductList(_api);
    super.initState();
  }

  FutureBuilder<ProductListModel> _buildPListModel(size) {
    return FutureBuilder<ProductListModel>(
      future: pListModel,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          ProductListModel _pListModel = sortProduct(snapshot.data);
          return PlistBody(productListModel: _pListModel, sortBasis: _sort);
        } else if (snapshot.hasError) {
          return Center(
            child: Container(
              child: Text("Ohh!! Some Error Occurred!!"),
            ),
          );
        } else {
          return customShimmer2(size);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.blueGrey.shade200,
      backgroundColor: kDarkBlue,
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kDarkBlue,
        leading: Container(),
        titleSpacing: 0,
        title: PhysicalModel(
          color: Colors.white,
          elevation: 0,
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
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: _buildPListModel(size),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildSortAndFilters(),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.filter_list_rounded),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      //   backgroundColor: kDarkBlue,
      //   onPressed: () {
      //     //showDialogBox(context);
      //     // var response =
      //     //     await ProductListController().getProductList(APIs.productAll);
      //     // print(response);
      //   },
      // ),
      // bottomNavigationBar: CustomBottomNavigationBar(selectedMenu: Menu.home),
    );
  }

  Padding _buildSortAndFilters() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(40)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.amber.shade400,
                  blurRadius: 0.7,
                  spreadRadius: 0.7,
                  offset: Offset(0, 0))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("tapped");
                  //todo sort based on prices
                  _onSortButtonTapped();
                },
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: Icon(Icons.compare_arrows),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Sort",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    width: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //Todo Filter the Category
                },
                child: Row(
                  children: [
                    Icon(Icons.filter_list_alt),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Filters",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _onSortButtonTapped() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _sort = Price.any;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12),
                    child: Text(
                      "Price: Any",
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              _sort == Price.any ? Colors.blue : Colors.black),
                    ),
                  ),
                ),
                Divider(
                  color: kDarkBlue,
                  height: 2,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _sort = Price.low;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12),
                    child: Text(
                      "Price: Low to High",
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              _sort == Price.low ? Colors.blue : Colors.black),
                    ),
                  ),
                ),
                Divider(
                  color: kDarkBlue,
                  height: 2,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _sort = Price.high;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12),
                    child: Text(
                      "Price: High to low",
                      style: TextStyle(
                          fontSize: 18,
                          color:
                              _sort == Price.high ? Colors.blue : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class PlistBody extends StatelessWidget {
  const PlistBody({
    @required this.productListModel,
    @required this.sortBasis,
    Key key,
  }) : super(key: key);
  final Price sortBasis;
  static const List<String> imageUrl = [
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/9140095/2019/4/1/f6934dba-622f-4cd8-80b2-3f2f26966d4e1554102654447-Mitera-Pink-Silk-Blned--Woven-Design-Party-wear-Banarasi-Sar-5.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2019/11/28/54bc693d-b8e9-4bd1-bcee-f29918cbbe651574893594096-4.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2021/6/26/92d6f741-0ae8-4bfd-938d-090f59cad1081624684557360-4.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/15751306/2021/10/6/caf230c4-36de-4d0e-9733-db99dc95a0561633517385414UnnatiSilksWomenBlueWovenDesign3.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/15553374/2021/9/21/73ed6234-16ed-4860-b7d5-704d25bd0a8e1632226349642TheChennaiSilksWomenBlueWovenDesign5.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/15192404/2021/8/18/951196ad-3699-403f-afff-3733c8296abc1629306154713PisaraWomenRedPrinted3.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2020/1/29/80540821-c258-4be7-b726-288f9281a0601580249433911-5.jpg",
    "https://assets.myntassets.com/h_720,q_90,w_540/v1/assets/images/productimage/2019/8/11/377767df-b98e-4326-9ac3-65a6443384451565465392479-5.jpg",
  ];
  final ProductListModel productListModel;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productListModel.count,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: getProportionateScreenWidth(1),
            crossAxisSpacing: getProportionateScreenWidth(2)),
        itemBuilder: (context, index) {
          var tempPro = productListModel.productList[index];
          return ProductListCard(
            pTitle: tempPro.productName,
            imageUrl: tempPro.productImage.isNotEmpty
                ? tempPro.productImage[0]
                : imageUrl[index % 8],
            price: tempPro.price,
            press: () {
              // var response = await ProductDetailsController()
              //     .getProductDetails(tempPro.id);

              // print(tempPro.id + " " + "$response");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetailsScreen(pId: tempPro.id);
              }));
            },
            color: Colors.white.withOpacity(0.6),
          );
        });
  }
}

class ProductListCard extends StatelessWidget {
  const ProductListCard({
    Key key,
    this.width = 140,
    this.aspectRatio = 1.02,
    @required this.press,
    this.color,
    this.imageUrl,
    this.pTitle,
    this.price,
  }) : super(key: key);
  final double width, aspectRatio;
  final GestureTapCallback press;
  final Color color;
  final String imageUrl, pTitle;
  final int price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.purple.shade100,
      borderRadius: BorderRadius.circular(15),
      onTap: press,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
        ),
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
                  // color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  clipBehavior: Clip.antiAlias,
                  child: ProgressiveImage(
                    placeholder: AssetImage('assets/logo/zlogo.png'),
                    thumbnail: AssetImage('assets/category/cotton.jpg'),
                    image: NetworkImage(imageUrl),
                    width: getProportionateScreenWidth(150),
                    height: getProportionateScreenHeight(150),
                  ),
                ),
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
                  color: Colors.indigo.shade50,
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
                            pTitle,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(16),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            // maxLines: 2,
                          ),
                          Text(
                            "\₹$price",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                              color: kDarkBlue.withOpacity(0.7),
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
          ],
        ),
      ),
    );
  }
}
