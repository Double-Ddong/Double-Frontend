import 'package:shop_app/components/filled_outline_button.dart';
import 'package:shop_app/models/Person.dart';
import '../../../constants.dart';
import 'package:shop_app/models/Chat.dart';
import 'package:shop_app/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';

import '../chat_screen.dart';
import 'chat_card.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return Column(
      children: [
        // Container(
        //   padding: EdgeInsets.fromLTRB(
        //       kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        //   color: kPrimaryColor,
        //   child: Row(
        //     children: [
        //       FillOutlineButton(press: () {}, text: "Recent Message"),
        //       SizedBox(width: kDefaultPadding),
        //       FillOutlineButton(
        //         press: () {},
        //         text: "Active",
        //         isFilled: false,
        //       ),
        //     ],
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
            itemCount: loginPerson.LastChat.length,
            itemBuilder: (context, index) => ChatCard(
              chat: loginPerson.LastChat[index],
              press: () {
                loginPerson.chatclick = loginPerson.LastChat[index].chatRoom;
                loginPerson.chatUserClick = loginPerson.LastChat[index].userId;
                //print(loginPerson.chatUserClick);
                Navigator.pushNamed(context, MessagesScreen.routeName, arguments: loginPerson);
              },
            ),
          ),
        ),
      ],
    );
  }
}
