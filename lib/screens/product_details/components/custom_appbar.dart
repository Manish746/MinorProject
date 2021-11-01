// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../size_config.dart';
// import '../../../components/rounded_icon_button.dart';

// class CustomAppBar extends PreferredSize {
//   final double rating;

//   CustomAppBar(this.rating);

//   @override
//   Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         // color: Color(0xFFF5F6F9),
//         color: Colors.blueGrey.shade300,
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: getProportionateScreenWidth(20),
//                 vertical: getProportionateScreenHeight(5),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   RoundedIconButton(
//                     icon: Icons.arrow_back,
//                     press: () => Navigator.pop(context),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
