import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/FriendCard.dart';
import 'package:shop_app/components/friend_list.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/Product.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import '../section_title.dart';

late Response response;
var dio = Dio();

class SimilarFriends extends StatefulWidget{
  @override
  _Mainpage1 createState() => _Mainpage1();
}

class _Mainpage1 extends State<SimilarFriends>{


  void GetFriends(String userid) async{

    response = await dio.get('http://$apiServer:3000/main/mainpage1/${userid}');
    Map responseBody = response.data;

    int depart_len = responseBody['data'][0].length;

    for(int i = 0; i < depart_len; i++){
      Friends department = Friends(
        responseBody['data'][0][i]['UserId'],
        responseBody['data'][0][i]['Profile'],
        responseBody['data'][0][i]['NickName'],
        Age : responseBody['data'][0][i]['Age'],
        department : true,
      );
      Departmentfriends.add(department);
    }
  }

  List<Friends> Departmentfriends = [];
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   print('size');
  // }
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, () async {
      final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
      // GetFriends(loginPerson.userid);
      response = await dio.get('http://$apiServer:3000/main/mainpage1/${loginPerson.userid}');
      Map responseBody = response.data;

      int depart_len = responseBody['data'][0].length;

      for(int i = 0; i < depart_len; i++){
        Friends department = Friends(
          responseBody['data'][0][i]['UserId'],
          responseBody['data'][0][i]['Profile'],
          responseBody['data'][0][i]['NickName'],
          Age : responseBody['data'][0][i]['Age'],
          department : true,
        );
        Departmentfriends.add(department);
      }
      print(Departmentfriends);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "나와 비슷한 학과 친구들", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
            [
              ...List.generate(
                Departmentfriends.length,
                    (index) {
                  // if (Departmentfriends[index].department)
                  //   return FriendCard(person : );
                  // return FriendsList();
                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
// Widget build(BuildContext context) {
//   // TODO: implement build
//   return Column(
//     children: [
//       Padding(
//         padding:
//         EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//         child: SectionTitle(title: "나와 비슷한 학과 친구들", press: () {}),
//       ),
//       SizedBox(height: getProportionateScreenWidth(20)),
//       SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children:
//           [
//             ...List.generate(
//               Departmentfriends.length,
//                   (index) {
//                 if (Departmentfriends[index].department)
//                   return FriendCard(friends : Departmentfriends[index]);
//                 // return FriendsList();
//                 return SizedBox
//                     .shrink(); // here by default width and height is 0
//               },
//             ),
//             SizedBox(width: getProportionateScreenWidth(20)),
//           ],
//         ),
//       )
//     ],
//   );
// }





}