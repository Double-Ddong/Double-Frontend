import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';

import 'scope_setting_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
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
                          Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
                        }
                    ),
                    SizedBox(width: getProportionateScreenWidth(65),),
                    Container(
                      alignment: Alignment(-0.8, 0.0),
                      child: Text(
                        "소개 범위 설정",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(50),),
                    TextButton(
                      child: Text(
                        "저장",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(18),
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
                      },
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                ScopeSettingForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
