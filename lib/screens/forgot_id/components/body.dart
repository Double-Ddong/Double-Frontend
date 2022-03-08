import 'package:flutter/material.dart';
import 'package:shop_app/components/no_account_text.dart';
import 'package:shop_app/components/socal_card.dart';
import 'package:shop_app/screens/forgot_id/forgot_id_screen.dart';
import '../../../size_config.dart';
import 'forgot_id_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
        SizedBox(
        width: double.infinity,
        child:
        Padding(
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
                    "아이디 찾기",
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
                    "입력한 핸드폰 번호로 \n전송된 인증번호를 입력해주세요",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(13),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                ForgotIdForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
          ),


      ),
    );
  }
}
