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


import '../../../constants.dart';
import '../../../size_config.dart';


class AuthSchoolForm extends StatefulWidget {
  @override
  _AuthSchoolFormState createState() => _AuthSchoolFormState();
}

class _AuthSchoolFormState extends State<AuthSchoolForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
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
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, AuthSchoolScreen2.routeName);
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
              text: "@ 학교웹메일주소",
            ),
        ),
      ],
    );
  }


  TextFormField buildSchoolFormField() {
    return TextFormField(
      // onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSchoolNullError);
        }
        // else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kSchoolNullError);
        // }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kSchoolNullError);
          return "";
        }
        // else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kSchoolNullError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "학교",
        hintText: "학교를 선택하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Plus Icon.svg"),
      ),
    );
  }
}
