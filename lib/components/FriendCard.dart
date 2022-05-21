import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/friends_list/friends_list_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.person,
  }) : super(key: key);

  final double width, aspectRetio;
  final Friends person;

  @override
  Widget build(BuildContext context) {
    final Person loginperson = ModalRoute.of(context)?.settings.arguments as Person;
    Friends friends;
    friends = loginperson.Department[loginperson.frienddetail];
    if(loginperson.whatkind == 1){
      friends = loginperson.Department[loginperson.frienddetail];
    }
    if(loginperson.whatkind == 2){
      friends = loginperson.Nearby[loginperson.frienddetail];
    }
    if(loginperson.whatkind == 3){
      friends = loginperson.MBTI[loginperson.frienddetail];
    }


    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          // onTap: () {
          //   Navigator.pushNamed(
          //     context,
          //     DetailsScreen.routeName,
          //     arguments: loginperson,
          //   );
          // },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: person.UserId.toString(),
                    child: Image.network(person.Profile),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
