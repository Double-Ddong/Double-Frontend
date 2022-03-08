import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class MailButton extends StatelessWidget {
  const MailButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: 200,
      height: getProportionateScreenHeight(60),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          side: BorderSide(
            color: Colors.black45,
            width: 1.0,),
          primary: kPrimaryColor,
          backgroundColor: Colors.white,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.black45,

          ),
        ),
      ),
    );
  }
}
