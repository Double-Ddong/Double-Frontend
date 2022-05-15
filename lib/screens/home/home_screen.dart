import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:shop_app/models/Person.dart';
import '../../size_config.dart';
import 'components/NavBar.dart';
import 'components/body.dart';
import 'components/home_header.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  late Response response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
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
                  onPressed: () async{
                    Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
                  }
              ),
            ],
            leading :
                Builder(
                  builder: (context) => IconButton(
                    icon: SvgPicture.asset("assets/icons/Menu.svg"),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                      },
                  ),
                ),
        ),
      body: Body(),
    );
  }


}
