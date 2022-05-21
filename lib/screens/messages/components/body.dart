import 'dart:math';

import 'package:shop_app/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/ChatMessage.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import 'chat_input_field.dart';
import '../../../size_config.dart';
import 'message.dart';

class Body extends StatelessWidget {
  List<ChatMessage> chatMessage = [];
  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    for(int i=0; i<loginPerson.Message.length; i++) {
      if(loginPerson.Message[i].chatRoom == loginPerson.chatclick) {
        chatMessage.add(loginPerson.Message[i]);
      }
    }
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: ListView.builder(
              itemCount: chatMessage.length,
              itemBuilder: (context, index) =>
                  Message(message: chatMessage[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
