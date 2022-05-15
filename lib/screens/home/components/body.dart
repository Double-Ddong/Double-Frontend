import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/friends_list/components/section_title.dart';
import 'package:shop_app/screens/home/components/MBTI_friends.dart';
import 'package:shop_app/screens/home/components/similar_friends.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'nearby_friends.dart';

import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            Categories(),
            SizedBox(height: getProportionateScreenWidth(15)),
            SimilarFriends(),
            SizedBox(height: getProportionateScreenWidth(30)),
            NearbyFriends(),
            SizedBox(height: getProportionateScreenWidth(30)),
            MBTIFriends(),
          ],
        ),
      ),
    );
  }
}
