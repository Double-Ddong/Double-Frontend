import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shop_app/models/Person.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ViewProfileForm extends StatefulWidget {
  @override
  _ViewProfileFormState createState() => _ViewProfileFormState();
}

class _ViewProfileFormState extends State<ViewProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  //bool universityMode = false;  // true - 같은 대학교 소개, false - 다른 대학교 소개
  //bool personMode = false; // true - 아는 사람 차단, false - 아른 사람 차단 X
  //String profile = '';
  //String nickName = '';
  //late int age;


  // void addError({String? error}) {
  //   if (!errors.contains(error))
  //     setState(() {
  //       errors.add(error);
  //     });
  // }
  //
  // void removeError({String? error}) {
  //   if (errors.contains(error))
  //     setState(() {
  //       errors.remove(error);
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildProfileImageFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProfileFormField(loginPerson),
        ],
      ),
    );
  }

  Center buildProfileImageFormField(Person loginPerson) {
    return Center(
      child:
        Image.network(loginPerson.profile, width: getProportionateScreenWidth(300), height: getProportionateScreenHeight(300)),
    );
  }

  Column buildProfileFormField(Person loginPerson) {
    return Column(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(10)),
        Container(
          alignment: Alignment(-0.9, 0.0),
          child: Text(
            '${loginPerson.nickname} (${loginPerson.age})',
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(10)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                loginPerson.university,
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
                loginPerson.department,
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
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(10)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                loginPerson.location,
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
                loginPerson.mbti,
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
                loginPerson.smoke,
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
          alignment: Alignment(-0.7, 0.0),
          child: Text(
            loginPerson.introduce,
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
          alignment: Alignment(-0.7, 0.0),
          child: Text(
            loginPerson.hobby,
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

