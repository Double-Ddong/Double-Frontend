import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Person.dart';
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

class Body extends StatelessWidget {
  late Response response;
  var dio = Dio();
  late String Profile = '';

  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: getProportionateScreenWidth(12),),
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName, arguments: loginPerson);
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
          Image.network(loginPerson.profile,
            width: getProportionateScreenWidth(150), height: getProportionateScreenHeight(150)),
          SizedBox(height: 20),
          SettingMenu(
            text: "내 프로필 보기",
            icon: "assets/icons/User Icon.svg",
            press: () => { Navigator.pushNamed(context, ViewProfileScreen.routeName, arguments: loginPerson) },
          ),
          SettingMenu(
            text: "소개 범위 설정",
            icon: "assets/icons/Flash Icon.svg",
            press: () { Navigator.pushNamed(context, ScopeSettingScreen.routeName, arguments: loginPerson); },
          ),
          SettingMenu(
            text: "비밀번호 변경",
            icon: "assets/icons/Settings.svg",
            press: () { Navigator.pushNamed(context, ModifyPasswordScreen.routeName, arguments: loginPerson); },
          ),
          SettingMenu(
            text: "회원 탈퇴",
            icon: "assets/icons/Trash.svg",
            press: () { Navigator.pushNamed(context, DeleteAccountScreen.routeName, arguments: loginPerson); },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          LogOutButton(
            text: "로그 아웃",
            press: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
