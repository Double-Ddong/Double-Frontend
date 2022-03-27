import 'package:flutter/material.dart';
import 'package:shop_app/screens/setting/components/profile_pic.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CookieList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.yellowAccent,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("리스트 입니다!"),
        // ),
        body: Center(
          child: _buildList(),
        ),
      ),
    );
    // return
      // Column(
      //   children : [
      //     Padding(
      //         padding:
      //         EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      //         child:
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               "받은 쿠키",
      //               style: TextStyle(
      //                 fontSize: getProportionateScreenWidth(20),
      //                 color: Colors.black,
      //               ),
      //             ),
      //           ],
      //         )
      //     ),
      //
      //
      //
      //     Padding(
      //       padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      //       child:
      //       Column(
      //           children: [
      //             Row(
      //                 children : [
      //
      //                   Container(
      //                     width: SizeConfig.screenWidth * 0.2,
      //                     height: SizeConfig.screenHeight * 0.08,
      //                     child: Text(
      //                       "닉네임",
      //                       style: TextStyle(
      //                           fontSize: getProportionateScreenWidth(20),
      //                           height: 1.75),
      //                       textAlign: TextAlign.center,
      //                     ),
      //                   ),
      //
      //                 ]
      //             ),
      //             Row(
      //                 children : [
      //
      //                   Container(
      //                     width: SizeConfig.screenWidth * 0.2,
      //                     height: 27,
      //                     decoration: BoxDecoration(
      //                       color: kSecondaryColor.withOpacity(0.1),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                     child: Text(
      //                       "나이",
      //                       style: TextStyle(height: 1.75),
      //                       textAlign: TextAlign.center,
      //                     ),
      //                   ),
      //                   SizedBox(width: getProportionateScreenWidth(10)),
      //                   Container(
      //                     width: SizeConfig.screenWidth * 0.2,
      //                     height: 25,
      //                     decoration: BoxDecoration(
      //                       color: kSecondaryColor.withOpacity(0.1),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                     child: Text("학교",
      //                       style: TextStyle(height: 1.75),
      //                       textAlign: TextAlign.center,),
      //                   ),
      //                   SizedBox(width: getProportionateScreenWidth(10)),
      //                   Container(
      //                     width: SizeConfig.screenWidth * 0.2,
      //                     height: 25,
      //                     decoration: BoxDecoration(
      //                       color: kSecondaryColor.withOpacity(0.1),
      //                       borderRadius: BorderRadius.circular(15),
      //                     ),
      //                     child: Text("학과",
      //                       style: TextStyle(height: 1.75),
      //                       textAlign: TextAlign.center,),
      //                   ),
      //                 ]
      //             )
      //
      //             // List.generate(
      //             //   categories.length,
      //             //   (index) => CategoryCard(
      //             //     // icon: categories[index]["icon"],
      //             //     text: categories[index]["text"],
      //             //     press: () {},
      //             //   ),
      //             // ),
      //           ]
      //       ),
      //     )]);
  }


}

Widget _buildList() => ListView(
  children: [
    _tile("김보현", "23", "광운대학교", "소프트웨어학과"),
    _tile("김보현", "23", "광운대학교", "소프트웨어학과"),
    _tile("김보현", "23", "광운대학교", "소프트웨어학과"),


  ],
);

ListTile _tile(String title, String subtitle1, String subtitle2, String subtitle3) => ListTile(
    title: Text(title),
    subtitle: Row(
                children : [

                  Container(
                    width: SizeConfig.screenWidth * 0.08,
                    height: 27,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      subtitle1,
                      style: TextStyle(height: 1.5),
                      textAlign: TextAlign.center,
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
                    child: Text(subtitle2,
                      style: TextStyle(height: 1.5),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(width: getProportionateScreenWidth(10)),
                  Container(
                    width: SizeConfig.screenWidth * 0.3,
                    height: 25,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(subtitle3,
                      style: TextStyle(height: 1.5),
                      textAlign: TextAlign.center,),
                  ),
                ]
            ) ,
    // Text(subtitle1),
    leading: ClipRRect(
      borderRadius : BorderRadius.circular(100),
      child: Image.network("https://randomuser.me/api/portraits/women/31.jpg"),
    )
    );
