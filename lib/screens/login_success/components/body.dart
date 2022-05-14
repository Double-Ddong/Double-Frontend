import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments;
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04,
            width : 500),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "로그인 성공",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "홈으로 돌아가기",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName, arguments: userId);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
