import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'cookielist.dart';
import 'home_header.dart';

class CookieGotScreen extends StatelessWidget{
  static String routeName = "/cookiegot";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title:
          Text(
            "받은 쿠키",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(20),
              color: Colors.black,
            ),
          ),
        ),
        body: CookieList()
    );
  }

}