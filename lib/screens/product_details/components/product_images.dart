import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    @required this.imageUrls,
  }) : super(key: key);

  final List<String> imageUrls;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Color(0xFFF5F6F9),
      color: Colors.blueGrey.shade200,

      child: Column(
        children: [
          SizedBox(
            width: getProportionateScreenHeight(240),
            child: InteractiveViewer(
              child: AspectRatio(
                aspectRatio: 1,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/logo/zlogo.png",
                  image: widget.imageUrls[selectedImage],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildSmallImagePreview(index);
              },
              itemCount: widget.imageUrls.length,
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildSmallImagePreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
        ),
        padding: EdgeInsets.all(getProportionateScreenHeight(4)),
        height: getProportionateScreenHeight(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedImage == index ? kPrimaryColor : Colors.transparent,
          ),
        ),
        child: Image.network(widget.imageUrls[index]),
      ),
    );
  }
}
