import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/view_profile/view_profile_screen.dart';
import 'package:shop_app/screens/scope_setting/scope_setting_screen.dart';
import 'package:shop_app/components/log_out_button.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/modify_password/modify_password_screen.dart';
import 'package:shop_app/screens/delete_account/delete_account_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';
import 'setting_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //padding: EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: getProportionateScreenWidth(12),),
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
              ),
              SizedBox(width: getProportionateScreenWidth(110),),
              Container(
                child: Text(
                  "설정",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]
          ),
          SizedBox(height: 20),
          ProfilePic(),
          SizedBox(height: 20),
          SettingMenu(
            text: "내 프로필 보기",
            icon: "assets/icons/User Icon.svg",
            press: () => { Navigator.pushNamed(context, ViewProfileScreen.routeName) },
          ),
          SettingMenu(
            text: "소개 범위 설정",
            icon: "assets/icons/Flash Icon.svg",
            press: () { Navigator.pushNamed(context, ScopeSettingScreen.routeName); },
          ),
          SettingMenu(
            text: "비밀번호 변경",
            icon: "assets/icons/Settings.svg",
            press: () { Navigator.pushNamed(context, ModifyPasswordScreen.routeName); },
          ),
          SettingMenu(
            text: "회원 탈퇴",
            icon: "assets/icons/Trash.svg",
            press: () { Navigator.pushNamed(context, DeleteAccountScreen.routeName); },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          LogOutButton(
            text: "로그 아웃",
            press: () {
              // if (_formKey.currentState!.validate()) {
              // {  _formKey.currentState!.save();
              // if all are valid then go to success screen
              Navigator.pushNamed(context, SignInScreen.routeName);
              // }
            },
          ),
        ],
      ),
    );
  }
}
