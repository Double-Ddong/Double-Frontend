import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/FriendCard.dart';
import 'package:shop_app/components/friend_list.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'section_title.dart';

late Response response;
var dio = Dio();

class Body extends StatefulWidget{
  @override
  _Body createState() => _Body();
}
// Widget getList(){
//   GridView.count(
//       crossAxisCount:2,
//       children : List.generate(10, (index) {
//         return Center(
//           child: Text("예시"),
//         );
//       }
//       )
//   );
// }
class _Body extends State<Body> {
  @override
  void initState() {
    // TODO: implement activate
    super.initState();
  }


// Widget listview(){
//   final List<Friends> friends = ModalRoute.of(context)?.settings.arguments as List<Friends>;
//   return ListView.builder(
//     itemCount: friends.length,
//     itemBuilder: (BuildContext context, int index){
//       return Container(
//         child: Center(child: Image.network(friends[index].Profile),),
//       );
//     },
//   )
// }
  @override
  Widget build(BuildContext context) {
    final Person loginperson = ModalRoute
        .of(context)
        ?.settings
        .arguments as Person;

    var friendtype = '';
    List<Friends> friendlist = [];

    if(loginperson.friendclick == 1){
      friendtype = loginperson.university;
      friendlist = loginperson.Department;
    }
    if(loginperson.friendclick == 2){
      friendtype = loginperson.location;
      friendlist = loginperson.Nearby;
    }
    if(loginperson.friendclick == 3){
      friendtype = loginperson.mbti;
      friendlist = loginperson.MBTI;
    }


    return Container(
        padding: const EdgeInsets.all((30)),
        child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${friendtype} 친구들",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),
                  ),
                  // GridView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     itemCount: friendlist.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       childAspectRatio: 1/1,
                  //
                  //     ),
                  //     itemBuilder: (BuildContext context, int index){
                  //       return Container(
                  //         width: 10,
                  //         height: 10,
                  //
                  //
                  //         child: Text("예시"),
                  //       );
                  //     })
                  // getList(),

                ],
              ),
            ]
        )

    );
  }

  //
  // Widget _buildList() =>
  //     ListView(
  //       children: [
  //         _tile("김보현", "23", "광운대학교", "소프트웨어학과"),
  //         _tile("최보현", "20", "서울대학교", "소프트웨어학과"),
  //         _tile("박보현", "23", "연세대학교", "소프트웨어학과"),
  //       ],
  //     );
  //
  // ListTile _tile(String title, String subtitle1, String subtitle2,
  //     String subtitle3) =>
  //     ListTile(
  //         title: Text(title),
  //         subtitle: Row(
  //             children: [
  //
  //               Container(
  //                 width: SizeConfig.screenWidth * 0.08,
  //                 height: 27,
  //                 decoration: BoxDecoration(
  //                   color: kSecondaryColor.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: Text(
  //                   subtitle1,
  //                   style: TextStyle(height: 1.5),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               SizedBox(width: getProportionateScreenWidth(10)),
  //               Container(
  //                 width: SizeConfig.screenWidth * 0.2,
  //                 height: 25,
  //                 decoration: BoxDecoration(
  //                   color: kSecondaryColor.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: Text(subtitle2,
  //                   style: TextStyle(height: 1.5),
  //                   textAlign: TextAlign.center,),
  //               ),
  //               SizedBox(width: getProportionateScreenWidth(10)),
  //               Container(
  //                 width: SizeConfig.screenWidth * 0.3,
  //                 height: 25,
  //                 decoration: BoxDecoration(
  //                   color: kSecondaryColor.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: Text(subtitle3,
  //                   style: TextStyle(height: 1.5),
  //                   textAlign: TextAlign.center,),
  //               ),
  //             ]
  //         ),
  //         // Text(subtitle1),
  //         leading: ClipRRect(
  //           borderRadius: BorderRadius.circular(100),
  //           child: Image.network(
  //               "https://randomuser.me/api/portraits/women/31.jpg"),
  //         )
  //     );
}

