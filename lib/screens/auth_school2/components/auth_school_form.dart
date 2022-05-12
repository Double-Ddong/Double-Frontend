import 'package:flutter/material.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';

class AuthSchoolForm2 extends StatefulWidget {

  const AuthSchoolForm2({
    Key? key,
  }) : super(key: key);

  @override
  _AuthSchoolForm2State createState() => _AuthSchoolForm2State();
}

class _AuthSchoolForm2State extends State<AuthSchoolForm2> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  String auth1 = '';
  String auth2 = '';
  String auth3 = '';
  String auth4 = '';
  String auth_num = '';

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final confirm_auth_num = ModalRoute.of(context)?.settings.arguments;
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: false,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                    auth1 = value;
                    print(auth1);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: false,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin3FocusNode);
                    auth2 = value;
                    print(auth2);
                  }
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: false,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin4FocusNode);
                    auth3 = value;
                    print(auth3);
                  }
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: false,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                      auth4 = value;
                      auth_num = '${auth1}${auth2}${auth3}${auth4}';
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("1분 내로 입력해주세요 "),
              TweenAnimationBuilder(
                tween: Tween(begin: 60.0, end: 0.0),
                duration: Duration(seconds: 30),
                builder: (_, dynamic value, child) => Text(
                  "00:${value.toInt()}",
                  style: TextStyle(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.09),
          DefaultButton(
            text: "완료",
            press: () {
              if(auth_num == confirm_auth_num) {
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
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
                              new Text("인증 실패"),
                            ],
                          ),
                          //
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "인증번호가 일치하지 않습니다.",
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
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CancelButton(
            text: "취소",
            press: () {
              // if (_formKey.currentState!.validate()) {
              // {  _formKey.currentState!.save();
              // if all are valid then go to success screen
              Navigator.pushNamed(context, SignInScreen.routeName);
              // }
            },
          ),
        ],
      ),
    );
  }
}