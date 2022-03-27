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
            SizedBox(width: getProportionateScreenWidth(15)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                "나이",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
                OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))
                  )
                ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                "학교",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                "학과",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                "MBTI",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Container(
          alignment: Alignment(-0.8, 0.0),
          child: Text(
            "자기소개",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          alignment: Alignment(-0.4, 0.0),
          child: Text(
            "안녕하세요~~ 저는 땡땡대학교 누구입니다",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          alignment: Alignment(-0.8, 0.0),
          child: Text(
            "취미",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          alignment: Alignment(-0.3, 0.0),
          child: Text(
            "저는 컴퓨터게임 좋아해요 롤 좋아하시는 분~",
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

