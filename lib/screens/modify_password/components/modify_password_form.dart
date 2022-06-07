import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/auth_phone/auth_phone_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';


class ModifyPasswordForm extends StatefulWidget {
  @override
  _ModifyPasswordFormState createState() => _ModifyPasswordFormState();
}

class _ModifyPasswordFormState extends State<ModifyPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? cur_password;
  String? password;
  String? conform_password;
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
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "현재 비밀번호를 입력하세요",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCurPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "변경할 비밀번호를 입력하세요",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(18),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "확인",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                response = await dio.post(
                  'http://$apiServer:3000/setting/changePW/${loginPerson.userid}',
                    data: {'CurPW': cur_password, 'NewPW': password}
                );

                Map responseBody = response.data;
                bool success = responseBody['success'];

                if(success){
                  Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
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
                                new Text("비밀번호 변경 실패"),
                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "비밀번호가 일치하지 않습니다",
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
          SizedBox(height: getProportionateScreenHeight(10)),
          CancelButton(
            text: "취소",
            press: () {
              Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildCurPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => cur_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
        //labelText: "비밀번호",
        hintText: "현재 비밀번호",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        //labelText: "비밀번호 확인",
        hintText: "비밀번호 한 번 더 입력",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        password = value;
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
        //labelText: "비밀번호",
        hintText: "변경할 비밀번호",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
