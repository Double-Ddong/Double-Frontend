import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.title,
    this.text,
    this.image,
  }) : super(key: key);
  final String? title, text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(flex: 30),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(270),
          width: getProportionateScreenWidth(265),
        ),
        Spacer(flex: 5),
        Text(
          title!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(23),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
