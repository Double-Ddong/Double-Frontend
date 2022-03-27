import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'cookielist.dart';
import 'home_header.dart';

class CookieScreen extends StatelessWidget{
  static String routeName = "/cookie";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:
          Text(
            "보낸 쿠키",
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