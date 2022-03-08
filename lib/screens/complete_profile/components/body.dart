import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

import 'complete_profile_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.0005),
                Image.asset("assets/images/logo.png", width: 80, height: 90),
                Container(
                  alignment: Alignment(-0.9, 0.0),
                  child: Text(
                    "프로필 입력",
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
                    "프로필을 정확하게 입력해주세요.\n신뢰할 수 있는 프로필을 작성하면\n더 잘 맞는 사람과 매칭됩니다!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
