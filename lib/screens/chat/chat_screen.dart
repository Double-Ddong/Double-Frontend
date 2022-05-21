import 'package:flutter/material.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/home/components/NavBar.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'components/body.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chat";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return AppBar(
      automaticallyImplyLeading: false,
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
              Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
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
    );
  }
}
