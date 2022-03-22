import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../friends_list_screen.dart';
import 'friends_list.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            // SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(15)),
            FriendsList(),
            SizedBox(height: getProportionateScreenWidth(30)),

          ],
        ),
      ),
    );
  }
}
