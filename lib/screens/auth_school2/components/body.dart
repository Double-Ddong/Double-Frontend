import 'package:flutter/material.dart';
import '../../../constants.dart';
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
                Container(
                  alignment: Alignment(-0.9, 0.0),
                  child: Text(
                    "학교 메일 인증하기",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Container(
                  alignment: Alignment(-0.8, 0.0),
                  child: Text(
                    "등록한 학교메일로 전송된 인증번호를 입력해주세요",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                AuthSchoolForm2(),
                //buildTimer(),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                GestureDetector(
                  onTap: () {
                    // OTP code resend
                  },
                  child: Text(
                    "재전송하기",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }}

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("1분 내로 입력해주세요 "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
