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
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
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
