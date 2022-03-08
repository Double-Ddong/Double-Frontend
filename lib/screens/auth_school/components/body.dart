import 'package:flutter/material.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';
import '../../../size_config.dart';
import 'auth_school_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Image.asset("assets/images/logo.png", width: 150, height: 100),
                Text(
                  "학교 메일 인증하기",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Text(
                  "자신의 학교 웹메일 아이디를 입력해주세요",
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                AuthSchoolForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                SizedBox(width: 200),
                                SizedBox(height: getProportionateScreenHeight(20)),
                // NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
