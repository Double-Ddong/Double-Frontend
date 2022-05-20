import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/FriendCard.dart';
import 'package:shop_app/components/friend_list.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/friends_list/friends_list_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';
late Response response;
var dio = Dio();

class NearbyFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "내 근처 친구들", press: () =>
                {
                loginPerson.friendclick = 2,
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
            children: [
              ...List.generate(
                loginPerson.Nearby.length,
                (index) {
                  if (loginPerson.Nearby[index].Nearby)
                    return FriendCard(friends : loginPerson.Nearby[index]);
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
