import 'package:flutter/material.dart';
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: kPrimaryColor,
      //   child: Icon(
      //     Icons.person_add_alt_1,
      //     color: Colors.white,
      //   ),
      // ),
      //bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  // BottomNavigationBar buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     type: BottomNavigationBarType.fixed,
  //     currentIndex: _selectedIndex,
  //     onTap: (value) {
  //       setState(() {
  //         _selectedIndex = value;
  //       });
  //     },
  //     items: [
  //       BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
  //       BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
  //       BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
  //       BottomNavigationBarItem(
  //         icon: CircleAvatar(
  //           radius: 14,
  //           backgroundImage: AssetImage("assets/images/user_2.png"),
  //         ),
  //         label: "Profile",
  //       ),
  //     ],
  //   );
  // }

  AppBar buildAppBar() {
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
    );
  }
}
