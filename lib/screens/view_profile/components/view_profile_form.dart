import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ViewProfileForm extends StatefulWidget {
  @override
  _ViewProfileFormState createState() => _ViewProfileFormState();
}

class _ViewProfileFormState extends State<ViewProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  bool universityMode = false;  // true - 같은 대학교 소개, false - 다른 대학교 소개
  bool personMode = false; // true - 아는 사람 차단, false - 아른 사람 차단 X

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildProfileImageFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProfileFormField(),
        ],
      ),
    );
  }

  Center buildProfileImageFormField() {
    return Center(
      child: 
        Image.asset("assets/images/Profile Image Basic.png", width: getProportionateScreenWidth(300), height: getProportionateScreenHeight(300)),
    );
  }

  Column buildProfileFormField() {
    return Column(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(10)),
        Container(
          alignment: Alignment(-0.9, 0.0),
          child: Text(
            "사용자 이름",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            OutlinedButton(
                onPressed: () => {},
                child: Text(
                  "나이",
                ),
            ),
          ],
        ),
        Container(
          child: Text(
            "해당 옵션을 설정하면 아는 사람들이 소개되지 않습니다.\n 해제하면 모든 친구들이 소개됩니다.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
      ],
    );
  }
}

