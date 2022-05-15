import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shop_app/models/Person.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
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

  late Response response;
  var dio = Dio();

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
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                onPressed: () {
                  Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
                }
            ),
            SizedBox(width: getProportionateScreenWidth(65),),
            Container(
              alignment: Alignment(-0.8, 0.0),
              child: Text(
                "소개 범위 설정",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(15),
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(50),),
            TextButton(
              child: Text(
                "저장",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenWidth(18),
                  //fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                response = await dio.get(
                  'http://13.125.168.216:3000/setting/setScope/${loginPerson.userid}/${loginPerson.scopeUniversity}/${loginPerson.scopePeople}',
                );

                Map responseBody = response.data;
                bool success = responseBody['success'];

                if(success){
                  Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
                }

              },
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(30)),
        Form(
          key: _formKey,
          child: Column(
            children: [
              buildUniversityFormField(loginPerson),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPersonFormField(loginPerson),
            ],
          ),
        ),
      ],
    );
  }

  Column buildUniversityFormField(Person loginPerson) {
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
              value: loginPerson.scopeUniversity == 1 ? true : false,
              onToggle: (value) {
                setState(() {
                  if(value) {
                    loginPerson.scopeUniversity = 1;
                  } else {
                    loginPerson.scopeUniversity = 0;
                  }
                  print(loginPerson.scopeUniversity);
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

  Column buildPersonFormField(Person loginPerson) {
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
              value: loginPerson.scopePeople == 1 ? true : false,
              onToggle: (value) {
                setState(() {
                  if(value) {
                    loginPerson.scopePeople = 1;
                  } else {
                    loginPerson.scopePeople = 0;
                  }
                  print(loginPerson.scopePeople);
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

