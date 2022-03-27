import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/friends_list/components/section_title.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"text": "학과별"},
      {"text": "위치별"},
      {"text": "MBTI"},
      // {"icon": "assets/icons/Gift Icon.svg", "text": "Daily Gift"},
      // {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return Column(
      children : [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "카테고리",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                  color: Colors.black,
                ),
              ),
            ],
          )
        ),
      Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      child:
        Column(
        children: [
          Row(
              children : [
                  Container(
                    width: SizeConfig.screenWidth * 0.2,
                    height: 27,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "학과별",
                      style: TextStyle(height: 1.75),
                      textAlign: TextAlign.center,
                      // textHeightBehavior:
                      // TextHeightBehavior(
                      //   applyHeightToFirstAscent: true,
                      //   applyHeightToLastDescent: true,
                      // ),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Container(
                    width: SizeConfig.screenWidth * 0.2,
                    height: 25,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text("위치별",
                      style: TextStyle(height: 1.75),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Container(
                    width: SizeConfig.screenWidth * 0.2,
                    height: 25,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text("MBTI",
                      style: TextStyle(height: 1.75),
                      textAlign: TextAlign.center,),
                  ),
              ]
          )

        // List.generate(
        //   categories.length,
        //   (index) => CategoryCard(
        //     // icon: categories[index]["icon"],
        //     text: categories[index]["text"],
        //     press: () {},
        //   ),
        // ),
        ]
      ),
    )]);
    // return Padding(
    //
    //   padding: EdgeInsets.all(getProportionateScreenWidth(10)),
    //   child: Row(
    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: List.generate(
    //       categories.length,
    //           (index) => CategoryCard(
    //         // icon: categories[index]["icon"],
    //         text: categories[index]["text"],
    //         press: () {},
    //       ),
    //     ),
    //   ),
    // );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    // required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  // final String? icon, text;
  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            // Container(
            //   padding: EdgeInsets.all(getProportionateScreenWidth(15)),
            //   height: getProportionateScreenWidth(55),
            //   width: getProportionateScreenWidth(55),
            //   decoration: BoxDecoration(
            //     color: Color(0xFFFFECDF),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: SvgPicture.asset(icon!),
            // ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.left)
          ],
        ),
      ),
    );
  }
}
