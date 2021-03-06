import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/models/Chat.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/messages/components/chat_message_form.dart';
import 'components/body.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';

import '../../../size_config.dart';
import '../../../constants.dart';

class MessagesScreen extends StatelessWidget {
  static String routeName = "/message";
  late String name = '';
  late String profile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ChatPage(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    for(int i=0; i<loginPerson.LastChat.length; i++) {
      if(loginPerson.LastChat[i].chatRoom == loginPerson.chatclick) {
        name = loginPerson.LastChat[i].name;
        profile = loginPerson.LastChat[i].image;
      }
    }
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
            "${name}",
            style: TextStyle(fontSize: 15, color: Colors.black,),
          ),
          //SizedBox(width : getProportionateScreenWidth(30)),
          Spacer(),
          CircleAvatar(
            backgroundImage: NetworkImage(profile),
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
