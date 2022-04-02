import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'components/body.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';

import '../../../size_config.dart';
import '../../../constants.dart';

class MessagesScreen extends StatelessWidget {
  static String routeName = "/message";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
              icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.routeName);
              }
          ),
          SizedBox(width : getProportionateScreenWidth(65)),
          Text(
            "Kristin Watson",
            style: TextStyle(fontSize: 15, color: Colors.black,),
          ),
          //SizedBox(width : getProportionateScreenWidth(30)),
          Spacer(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
        ],
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.local_phone),
      //     onPressed: () {},
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.videocam),
      //     onPressed: () {},
      //   ),
      //   SizedBox(width: kDefaultPadding / 2),
      // ],
    );
  }
}
