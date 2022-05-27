import 'dart:math';

import 'package:shop_app/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/models/ChatMessage.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import 'chat_input_field.dart';
import '../../../size_config.dart';
import 'chat_message_form.dart';
import 'message.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;

    return ChatPage();
  }
}
