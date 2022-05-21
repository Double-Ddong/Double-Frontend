import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Person.dart';
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
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
              icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.routeName, arguments: loginPerson);
              }
          ),
          SizedBox(width : getProportionateScreenWidth(65)),
          Text(
            "${loginPerson.LastChat[loginPerson.chatclick].name}",
            style: TextStyle(fontSize: 15, color: Colors.black,),
          ),
          //SizedBox(width : getProportionateScreenWidth(30)),
          Spacer(),
          CircleAvatar(
            backgroundImage: NetworkImage(loginPerson.LastChat[loginPerson.chatclick].image),
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
