import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/home/components/NavBar.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';

import '../../size_config.dart';
import 'components/body.dart';


class ChatScreen extends StatelessWidget {
  static String routeName = "/chatscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  NavBar(),
      appBar:
      AppBar(
        title: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [ Image.asset("assets/images/logo.png", width: 60, height: 60)]
            )
        ),
        actions: [
          IconButton(
              icon: SvgPicture.asset("assets/icons/Settings.svg"),
              onPressed: () {
                Navigator.pushNamed(context, SettingScreen.routeName);
              }
          ),
        ],
        leading :
        Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset("assets/icons/Menu.svg"),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),

        // IconButton(
        //     icon: SvgPicture.asset("assets/icons/Menu.svg"),
        //     onPressed: () =>
        //       // Navigator.pushNamed(context, CartScreen.routeName);
        //       Scaffold.of(context).openDrawer()
        //
        // ),
      ),

      // body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
