import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(330),
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide(
            color: kPrimaryColor,
            width: 1.0,),
          primary: kPrimaryColor,
          backgroundColor: Colors.white,

        ),

        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: kPrimaryColor,

          ),
        ),
      ),
    );
  }
}
