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
  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    ChatMessage sendMessage;
    int messagelen = loginPerson.Message.length;
    for(int i=0; i<messagelen; i++) {
      if(i == loginPerson.chatclick) {
        List<ChatMessage>? receive = loginPerson.Message[i];
      }
    }
    return Column(
      children: [
        // Expanded(
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        //     child: ListView.builder(
        //       itemCount: loginPerson.Message.length,
        //       itemBuilder: (context, index) =>
        //           Message(message: loginPerson.Message[loginPerson.Message.length-1]![index]),
        //     ),
        //   ),
        // ),
        ChatInputField(),
      ],
    );
  }
}
