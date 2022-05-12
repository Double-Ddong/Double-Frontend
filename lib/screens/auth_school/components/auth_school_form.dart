import 'package:flutter/material.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/mail_text.dart';
import 'package:shop_app/components/send_button.dart';
import 'package:shop_app/screens/auth_school2/auth_school_screen2.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:dio/dio.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

String? confirm_auth_num;

class AuthSchoolForm extends StatefulWidget {
  @override
  _AuthSchoolFormState createState() => _AuthSchoolFormState();
}

class _AuthSchoolFormState extends State<AuthSchoolForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? sendEmail;
  String? password;

  //String? confirm_password;
  //bool remember = false;
  var university = ['KDB금융대학교'];
  String selectedUniversity = 'KDB금융대학교';
  late String universityMail = '';
  final List<String?> errors = [];
  late Response response;
  var dio = Dio();

  void getUnivList() async {
    try {
      response = await dio.get('http://13.125.168.216:3000/auth/getUnivName');
      Map responseBody = response.data;
      bool success = responseBody['success'];

      if (success) {
        int univlen = responseBody['data'].length;
        for (int i = 1; i < univlen; i++) {
          university.add(responseBody['data'][i].toString());
        }
      }

      var myRes = university.toSet();
      university = myRes.toList();

    } catch(e) { print(e); }
  }

  void getUnivMail() async {
    try {
      response = await dio.get('http://13.125.168.216:3000/auth/getUnivName/getMail/${selectedUniversity}');
      Map responseBody = response.data;
      bool success = responseBody['success'];

      if (success) {
        universityMail = responseBody['data'];
      }

    } catch(e) { print(e); }
  }

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
    getUnivList();
    final userId = ModalRoute.of(context)?.settings.arguments;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildSchoolFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "다음",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                sendEmail = '${email}@${universityMail}.ac.kr';
                response = await dio.post('http://13.125.168.216:3000/auth/univMailAuth', data: {'Email': sendEmail});
                Map responseBody = response.data;
                bool success = responseBody['success'];

                if (success) {
                  confirm_auth_num = responseBody['data']['sendNum'];
                  response = await dio.post('http://13.125.168.216:3000/auth/univMailAuth/OK/${userId}',
                      data: {'University': selectedUniversity, 'UniversityEmail': sendEmail});
                  Map responseBody2 = response.data;
                  print(responseBody2);
                  bool success2 = responseBody2['success'];

                  if (success2) {
                    Navigator.pushNamed(context, AuthSchoolScreen2.routeName, arguments: [confirm_auth_num, userId]);
                  }
                }

              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CancelButton(
            text: "취소",
            press: () {
              // if (_formKey.currentState!.validate()) {
              {  _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Row buildPhoneFormField() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: SizeConfig.screenWidth * 0.45,
          child: TextFormField(
            onChanged: (value) {
              email = value;
              if (value.isNotEmpty) {
                removeError(error: kIdNullError);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kIdNullError);
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "웹메일 아이디",
              hintText: "아이디입력",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.43,
          child:
            MailButton(
              text: '@${universityMail}.ac.kr',
            ),
        ),
      ],
    );
  }


 Container buildSchoolFormField() {
     return Container(
       width: SizeConfig.screenWidth,
       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(30),
         border: Border.all(
             color: Colors.black54
         ),
       ),
       child: DropdownButton<String>(
         isExpanded: true,
         value: selectedUniversity,
         onChanged: (String? newValue) =>
             setState(() {
               selectedUniversity = newValue!;
               getUnivMail();
             }),
         items: university
             .map<DropdownMenuItem<String>>(
                 (String value) => DropdownMenuItem<String>(
               value: value,
               child: Text(
                 value,
                 style: Theme.of(context).textTheme.bodyText1,
                 textAlign: TextAlign.center,
               ),
             ))
             .toList(),
         icon: Icon(Icons.arrow_drop_down),
         iconSize: 35,
         underline: SizedBox(),
       ),
     );
  }
}
