import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:shop_app/screens/modify_profile/modify_profile_screen.dart';

import 'view_profile_form.dart';

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
                    SizedBox(width: getProportionateScreenWidth(210),),
                    TextButton(
                      child: Text(
                        "수정",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: getProportionateScreenWidth(18),
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, ModifyProfileScreen.routeName, arguments: loginPerson);
                      },
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                ViewProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
