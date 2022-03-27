import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'dart:math';
import 'User_1.dart';
import 'User_2.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(40)),
              Container(
                alignment: Alignment(0.8, 0.0),
                child: Transform.rotate(
                  angle: 5 * pi / 180,
                  child: UserOne(),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Container(
                alignment: Alignment(-0.8, 0.0),
                child: Transform.rotate(
                  angle: -5 * pi / 180,
                  child: UserTwo(),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(50)),
              Text(
                "서로 채팅 할 수 있어요!",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenWidth(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "채팅방이 생성되었습니다.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(15),
                  //fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(100)),
              DefaultButton(
                text: "채팅 시작하기",
                press: () {
                  //Navigator.pushNamed(context, MatchScreen.routeName);
                }
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              CancelButton(
                text: "취소",
                press: () {
                  //Navigator.pushNamed(context, MatchScreen.routeName);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
