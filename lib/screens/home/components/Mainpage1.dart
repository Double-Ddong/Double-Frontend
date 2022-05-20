import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/FriendCard.dart';
import 'package:shop_app/components/friend_list.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/friends_list/friends_list_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

late Response response;
var dio = Dio();

class Mainpage1 extends StatefulWidget{
  @override
  _Mainpage1 createState() => _Mainpage1();
}

class _Mainpage1 extends State<Mainpage1>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "나와 비슷한 학과 친구들", press: () =>
          {
            loginPerson.friendclick = 1,
            Navigator.pushNamed(
            context, FriendsListScreen.routeName,
            arguments: loginPerson,
          ),
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
            [
              ...List.generate(
                loginPerson.Department.length,
                    (index) {
                  if (loginPerson.Department[index].department)
                    return FriendCard(friends : loginPerson.Department[index]);
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