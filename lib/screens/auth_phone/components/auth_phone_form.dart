import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/send_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/auth_school/auth_school_screen.dart';


import '../../../constants.dart';
import '../../../size_config.dart';


class AuthPhoneForm extends StatefulWidget {
  @override
  _AuthPhoneFormState createState() => _AuthPhoneFormState();
}

class _AuthPhoneFormState extends State<AuthPhoneForm> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? auth_num;
  String? conform_auth_num = '123456';
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
            text: "다음",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, AuthSchoolScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformAuthNumFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      obscureText: true,
      onSaved: (newValue) => conform_auth_num = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAuthPhoneNullError);
        } else if (value.isNotEmpty && auth_num == conform_auth_num) {
          removeError(error: kMatchAuthPhoneError);
        }
        conform_auth_num = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAuthPhoneNullError);
          return "";
        } else if ((auth_num != value)) {
          addError(error: kMatchAuthPhoneError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "비밀번호 확인",
        hintText: "비밀번호 한 번 더 입력",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAuthNumFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      obscureText: false,
      onSaved: (newValue) => auth_num = newValue,
      onChanged: (newValue) {
        if (newValue.isNotEmpty) {
          removeError(error: kAuthPhoneNullError);
        } else if (newValue.isNotEmpty && auth_num == conform_auth_num) {
          removeError(error: kMatchAuthPhoneError);
        }
      },
      validator: (newValue) {
        if (newValue!.isEmpty) {
          addError(error: kAuthPhoneNullError);
          return "";
        } else if ((conform_auth_num != newValue)) {
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
          width: 245,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phone = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPhoneNumberNullError);
                }
                return null;
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
          press: () {
            // 서버에서 인증번호 전송하고, 인증번호 받아오기
            //if (_formKey.currentState!.validate()) {
              //_formKey.currentState!.save();
              // if all are valid then go to success screen
              //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
            //}
          },
        ),
      ],
    );
  }
}
