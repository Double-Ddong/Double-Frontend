import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import 'components/body.dart';

class FriendsListScreen extends StatelessWidget {
  static String routeName = "/friendlist";
  // List info = [];
  // _initData() {
  //   DefaultAssetBundle.of(context).loadString("assets/json/info.json").then((
  //       value) {
  //     info = json.decode(value);
  //   });
  // }
  //
  // @override
  // void initState(){
  //   // super.initState();
  //   _initData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
