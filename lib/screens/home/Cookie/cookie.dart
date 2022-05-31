import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'ReceiveCookieList.dart';
import 'cookielist.dart';
import '../components/home_header.dart';

class CookieScreen extends StatelessWidget{
  static String routeName = "/cookie";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title:
          Padding (
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
              child : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children : [
                    Text(
                      "받은 쿠키",
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(20),
                        color: Colors.black,
                      ),
                    ),]
              )
          )
      ),
      body: ReceiveCookieList()
    );
  }

}