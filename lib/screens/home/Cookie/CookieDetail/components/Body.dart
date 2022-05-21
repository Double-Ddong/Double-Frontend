import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:shop_app/screens/modify_profile/modify_profile_screen.dart';
import 'package:shop_app/screens/friends_list/friends_list_screen.dart';

import '../../../Cookie/cookie.dart';
import 'ViewProfileInCookie.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Person loginperson = ModalRoute
        .of(context)
        ?.settings
        .arguments as Person;
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
                    IconButton(
                        icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                        onPressed: () {
                          Navigator.pushNamed(context, CookieScreen.routeName, arguments: loginperson);
                        }
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                ViewProfileInCookie(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
