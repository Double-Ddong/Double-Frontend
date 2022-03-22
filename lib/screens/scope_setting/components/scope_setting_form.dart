import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ScopeSettingForm extends StatefulWidget {
  @override
  _ScopeSettingFormState createState() => _ScopeSettingFormState();
}

class _ScopeSettingFormState extends State<ScopeSettingForm> {
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
          buildUniversityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPersonFormField(),
        ],
      ),
    );
  }

  Column buildUniversityFormField() {
    return Column(
      children: <Widget> [
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(10)),
            Container(
              //alignment: Alignment(-0.9, 0.0),
              child: Text(
                "같은 대학교 사람 소개",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(20),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(70)),
            FlutterSwitch(
              height: 20.0,
              width: 40.0,
              padding: 4.0,
              toggleSize: 15.0,
              borderRadius: 10.0,
              activeColor: kPrimaryColor,
              value: universityMode,
              onToggle: (value) {
                setState(() {
                  universityMode = value;
                });
              },
            ),
          ],
        ),
        Container(
          //alignment: Alignment(-0.8, 0.0),
          child: Text(
            "해당 옵션을 설정하면 같은 대학교의 친구들만 소개됩니다.\n 해제하면 다른 대학교의 친구들도 함께 소개됩니다.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
      ],
    );
  }

  Column buildPersonFormField() {
    return Column(
      children: <Widget> [
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(10)),
            Container(
              //alignment: Alignment(-0.9, 0.0),
              child: Text(
                "아는 사람 소개(전화번호)",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(20),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(45)),
            FlutterSwitch(
              height: 20.0,
              width: 40.0,
              padding: 4.0,
              toggleSize: 15.0,
              borderRadius: 10.0,
              activeColor: kPrimaryColor,
              value: personMode,
              onToggle: (value) {
                setState(() {
                  personMode = value;
                });
              },
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

