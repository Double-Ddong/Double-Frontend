import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
