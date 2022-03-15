import 'package:flutter/material.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';
import '../../../constants.dart';

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
                      Navigator.pushNamed(context, SettingScreen.routeName);
                    }
                ),
                SizedBox(width: getProportionateScreenWidth(100),),
                Container(
                  alignment: Alignment(-0.8, 0.0),
                  child: Text(
                    "회원 탈퇴",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    ),
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}
