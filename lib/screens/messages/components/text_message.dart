import 'package:shop_app/models/ChatMessage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

import '../../../constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: message!.isSender ? kPrimaryColor : Colors.white10,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenHeight(15),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender
              ? Colors.white
              : Colors.black,
        ),
      ),
    );
  }
}
