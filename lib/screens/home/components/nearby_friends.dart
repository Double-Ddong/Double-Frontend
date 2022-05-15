import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/FriendCard.dart';
import 'package:shop_app/components/friend_list.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';
late Response response;
var dio = Dio();
List<Friends> Departmentfriends = [];
void GetFriends(String userid) async{
  response = await dio.get('http://13.125.168.216:3000/main/mainpage1/${userid}');
  Map responseBody = response.data;
  print(responseBody);
  int depart_len = responseBody['data'][0].length;

  print(responseBody['data'][1].length);
  for(int i = 0; i < depart_len; i++){

    Friends department = Friends(
      responseBody['data'][0][i]['UserId'],
      responseBody['data'][0][i]['Profile'],
      responseBody['data'][0][i]['NickName'],
      responseBody['data'][0][i]['Age'],
      department : true,
    );
    print(department);
    Departmentfriends.add(department);
  }

  print(Departmentfriends);
}
class NearbyFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    GetFriends(loginPerson.userid);
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "내 근처 친구들", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                Departmentfriends.length,
                (index) {
                  if (Departmentfriends[index].department)
                    return FriendCard(friends : Departmentfriends[index]);
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
}
