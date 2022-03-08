import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/components/send_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? nickName;
  String? phoneNumber;
  String? birthday;
  bool genderMode = false;  // true - 남자, false - 여자

  DateTime? _selectedDate;

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
          buildNickNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGenderFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBirthFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, OtpScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Row buildBirthFormField() {
    return Row(
      children: [
        SizedBox(
          width: 245,
          child: Container(
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: '생년월일',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                  _selectedDate != null
                      ? _selectedDate.toString()
                      : 'No date selected!',
                  style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ),
        Spacer(),
        SendButton(
          text: "선택",
          press:  _presentDatePicker,
        ),
      ]
    );
  }

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate = pickedDate;
      });
    });
  }

  Row buildGenderFormField() {
    return Row(
      children: <Widget> [
        OutlinedButton(
          onPressed: () {
            setState(() {
              genderMode = true;
            });
          },
          child: Text(
            "남자",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          style: OutlinedButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            primary: Colors.white,
            minimumSize: Size(160, 55),
            side: BorderSide(
                color: Colors.black,
                width: 0.8
            ),
            backgroundColor: genderMode ?  Colors.black12 : Colors.white,
          ),
        ),
        Spacer(),
        OutlinedButton(
          onPressed: () {
            setState(() {
              genderMode = false;
            });
          },
          child: Text(
            "여자",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          style: OutlinedButton.styleFrom(
            shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            primary: Colors.white,
            minimumSize: Size(160, 55),
            side: BorderSide(
                color: Colors.black,
                width: 0.8
            ),
            backgroundColor: genderMode ? Colors.white : Colors.black12,
          ),
        ),
      ],
    );
  }

  TextFormField buildNickNameFormField() {
    return TextFormField(
      onSaved: (newValue) => nickName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNickNameNullError);
        } else if (value.length <= 10) {
          removeError(error: kLongNickNameError);
        }
        nickName = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNickNameNullError);
          return "";
        } else if (value.length > 10) {
          addError(error: kLongNickNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "닉네임",
        hintText: "10자 이내로 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
