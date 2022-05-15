import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/screens/forgot_id/forgot_id_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/models/Person.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("자동 로그인"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotIdScreen.routeName),
                child: Text(
                  "아이디 찾기",
                  style: TextStyle(color: kPrimaryColor, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(
                    context, ForgotPwScreen.routeName),
                child: Text(
                  "비밀번호 찾기",
                  style: TextStyle(color: kPrimaryColor,decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "로그인",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);

                response = await dio.post('http://13.125.168.216:3000/auth/signin', data: {'Email': email, 'Password': password});
                //response = await dio.post('http://192.168.35.217:3000/auth/signin', data: {'Email': email, 'Password': password});
                Map responseBody1 = response.data;
                bool success = responseBody1['success'];

                if(success) {
                  String userId = responseBody1['data']['userid'].toString();
                  response = await dio.get('http://13.125.168.216:3000/main/mainpage3/${userId}');
                  Map responseBody2 = response.data;
                  bool success = responseBody2['success'];

                  if(success) {
                    response = await dio.get('http://13.125.168.216:3000/main/tab/${userId}');
                    Map responseBody3 = response.data;
                    bool success = responseBody3['success'];

                    if(success) {
                      response = await dio.get('http://13.125.168.216:3000/setting/getScope/${userId}');
                      Map responseBody4 = response.data;
                      bool success = responseBody4['success'];

                      if(success){
                        //print(responseBody4['message'][0]['ScopeUniversity']);
                        Person loginPerson = Person(
                            userId.toString(),
                            responseBody2['data'][0][0]['Profile'], responseBody2['data'][0][0]['NickName'],
                            responseBody2['data'][0][0]['University'], responseBody2['data'][0][0]['Department'],
                            responseBody2['data'][0][0]['MBTI'], responseBody2['data'][0][0]['Location'],
                            responseBody2['data'][0][0]['Smoke'], responseBody2['data'][0][0]['Drink'],
                            responseBody2['data'][0][0]['Hobby'], responseBody2['data'][0][0]['Introduce'],
                            responseBody2['data'][0][0]['Age'].toString(), responseBody2['data'][0][0]['Birth'],
                            responseBody2['data'][0][0]['Phone'].toString(), responseBody2['data'][0][0]['Height'].toString(),
                            responseBody3['data'][0]['SendCookie'].toString(), responseBody3['data'][0]['ReceiveCookie'].toString(),
                            responseBody3['data'][0]['Email'], responseBody4['message'][0]['ScopeUniversity'],
                            responseBody4['message'][0]['ScopePeople']);
                        Navigator.pushNamed(context, LoginSuccessScreen.routeName, arguments: loginPerson);
                      }
                    }
                  }
                } else {
                  void FlutterDialog() {
                    showDialog(
                        context: context,
                        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            //Dialog Main Title
                            title: Column(
                              children: <Widget>[
                                new Text("로그인 실패"),
                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "ID 혹은 비밀번호가 \n일치하지 않습니다",
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("확인"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  }
                  FlutterDialog();
                }

              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "비밀번호",
        hintText: "비밀번호를 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "이메일",
        hintText: "이메일을 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
