import 'package:flutter/material.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/send_button.dart';
import 'package:shop_app/components/form_error.dart';

import 'package:shop_app/screens/sign_in/sign_in_screen.dart';


import '../../../constants.dart';
import '../../../size_config.dart';
import '../forgot_password_screen.dart';
import 'package:dio/dio.dart';

class ForgotPwForm extends StatefulWidget {
  @override
  _ForgotPwFormState createState() => _ForgotPwFormState();
}

class _ForgotPwFormState extends State<ForgotPwForm> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? auth_num;
  String? confirm_auth_num;
  bool remember = false;
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
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAuthNumFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          DefaultButton(
            text: "완료",
            press: () async{
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                if(auth_num == confirm_auth_num) {

                  response = await dio.post('http://13.125.168.216:3000/auth/findPW/getPW',data: {'Phone': phone});
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
                                new Text("인증 성공"),
                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "사용자의 이메일로 새 비밀번호가 전송되었습니다"
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
              }
                ,
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

  // TextFormField buildConformAuthNumFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.phone,
  //     obscureText: true,
  //     onSaved: (newValue) => conform_auth_num = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kAuthPhoneNullError);
  //       } else if (value.isNotEmpty && auth_num == conform_auth_num) {
  //         removeError(error: kMatchAuthPhoneError);
  //       }
  //       conform_auth_num = value;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kAuthPhoneNullError);
  //         return "";
  //       } else if ((auth_num != value)) {
  //         addError(error: kMatchAuthPhoneError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "비밀번호 확인",
  //       hintText: "비밀번호 한 번 더 입력",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     ),
  //   );
  // }

  TextFormField buildAuthNumFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      obscureText: false,
      onSaved: (newValue) => auth_num = newValue,
      onChanged: (newValue) {
        if (newValue.isNotEmpty) {
          removeError(error: kAuthPhoneNullError);
        }
        auth_num = newValue;
      },
      validator: (newValue) {
        if (newValue!.isEmpty) {
          addError(error: kAuthPhoneNullError);
          return "";
        } else if ((confirm_auth_num != newValue)) {
          addError(error: kMatchAuthPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "인증번호",
        hintText: "인증번호를 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

    Row buildPhoneFormField() {
      return Row(
        children: <Widget> [
          SizedBox(
            width: SizeConfig.screenWidth * 0.65,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              onSaved: (newValue)  {
                phone = newValue;
              },
              onChanged: (value) {
                phone = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kPhoneNumberNullError);
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "핸드폰 번호",
                hintText: "핸드폰 번호",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if you r using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
              ),
            ),
          ),
          Spacer(),
          SendButton(
              text: "전송",
              press: () async {
                // 서버에서 인증번호 전송하고, 인증번호 받아오기
                response = await dio.post('http://13.125.168.216:3000/auth/findID', data: {'Phone': phone});
                print(phone);
                Map responseBody = response.data;
                //print(response.data);
                bool success = responseBody['success'];

                if (success) {
                  confirm_auth_num = responseBody['data'];
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
                                  "인증에 실패하였습니다.\n다시 시도해주세요.",
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
          ),
          // SizedBox(height: getProportionateScreenHeight(10)),
          // CancelButton(
          //   text: "취소",
          //   press: () {
          //     // if (_formKey.currentState!.validate()) {
          //     // {  _formKey.currentState!.save();
          //     // if all are valid then go to success screen
          //     Navigator.pushNamed(context, SignInScreen.routeName);
          //     // }
          //   },
          // ),
        ],
      );
  }
}
