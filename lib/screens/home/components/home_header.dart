import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //SearchField(),
          IconButton(
            icon: SvgPicture.asset("assets/icons/Menu.svg"),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            }
          ),
          Image.asset("assets/images/logo.png", width: 60, height: 60),
          IconButton(
            icon: SvgPicture.asset("assets/icons/Settings.svg"),
            onPressed: () {
              Navigator.pushNamed(context, SettingScreen.routeName);
            }
          ),
        ],
      ),
    );
  }
}
