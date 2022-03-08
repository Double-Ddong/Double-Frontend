import 'package:flutter/material.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.007), // 4%
                Image.asset("assets/images/logo.png", width: 150, height: 100),
                Container(
                  alignment: Alignment(-0.9, 0.0),
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  '가입하면 약관, 데이터 정책 및 쿠키 정책에 \n동의하는 것입니다.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
