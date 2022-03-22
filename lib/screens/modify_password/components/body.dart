import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';

import 'modify_password_form.dart';

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
                Row(
                  children: [
                    //SizedBox(width: getProportionateScreenWidth(5),),
                    IconButton(
                        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                        onPressed: () {
                          Navigator.pushNamed(context, SettingScreen.routeName);
                        }
                    ),
                    SizedBox(width: getProportionateScreenWidth(75),),
                    Container(
                      alignment: Alignment(-0.8, 0.0),
                      child: Text(
                        "비밀번호 변경",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                ModifyPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
