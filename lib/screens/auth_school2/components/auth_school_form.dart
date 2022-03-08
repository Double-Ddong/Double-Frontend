// import 'package:flutter/material.dart';
// import 'package:shop_app/components/cancel_button.dart';
// import 'package:shop_app/components/custom_surfix_icon.dart';
// import 'package:shop_app/components/default_button.dart';
// import 'package:shop_app/components/form_error.dart';
// import 'package:shop_app/components/mail_text.dart';
// import 'package:shop_app/components/send_button.dart';
// import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
//
//
// import '../../../constants.dart';
// import '../../../size_config.dart';
//
//
// class AuthSchoolForm extends StatefulWidget {
//   @override
//   _AuthSchoolFormState createState() => _AuthSchoolFormState();
// }
//
// class _AuthSchoolFormState extends State<AuthSchoolForm> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   String? conform_password;
//   bool remember = false;
//   final List<String?> errors = [];
//
//   void addError({String? error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   }
//
//   void removeError({String? error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildSchoolFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           // buildPhoneFormField(),
//           FormError(errors: errors),
//           SizedBox(height: getProportionateScreenHeight(40)),
//           DefaultButton(
//             text: "다음",
//             press: () {
//               if (_formKey.currentState!.validate()) {
//                 _formKey.currentState!.save();
//                 // if all are valid then go to success screen
//                 Navigator.pushNamed(context, CompleteProfileScreen.routeName);
//               }
//             },
//           ),
//           SizedBox(height: getProportionateScreenHeight(10)),
//           CancelButton(
//             text: "취소",
//             press: () {
//               // if (_formKey.currentState!.validate()) {
//               {  _formKey.currentState!.save();
//                 // if all are valid then go to success screen
//                 Navigator.pushNamed(context, SignInScreen.routeName);
//               }
//             },
//           ),
//
//         ],
//       ),
//
//     );
//   }
//
//   Row buildPhoneFormField() {
//     return Row(
//       children: <Widget>[
//         SizedBox(
//           width: 160,
//           child: TextFormField(
//             // keyboardType: TextInputType.phone,
//             // onSaved: (newValue) => phone = newValue,
//             onChanged: (value) {
//               if (value.isNotEmpty) {
//                 removeError(error: kIdNullError);
//               }
//               return null;
//             },
//             validator: (value) {
//               if (value!.isEmpty) {
//                 addError(error: kIdNullError);
//                 return "";
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               labelText: "웹메일 아이디",
//               hintText: "아이디입력",
//               // If  you are using latest version of flutter then lable text and hint text shown like this
//               // if you r using flutter less then 1.20.* then maybe this is not working properly
//               floatingLabelBehavior: FloatingLabelBehavior.always,
//             ),
//           ),
//         ),
//         Spacer(),
//         SizedBox(
//           width: 200,
//           child:
//           MailButton(
//             text: "@ 학교웹메일주소",
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   TextFormField buildSchoolFormField() {
//     return TextFormField(
//       // onSaved: (newValue) => email = newValue,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kSchoolNullError);
//         }
//         // else if (emailValidatorRegExp.hasMatch(value)) {
//         //   removeError(error: kSchoolNullError);
//         // }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kSchoolNullError);
//           return "";
//         }
//         // else if (!emailValidatorRegExp.hasMatch(value)) {
//         //   addError(error: kSchoolNullError);
//         //   return "";
//         // }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "학교",
//         hintText: "학교를 선택하세요",
//         // If  you are using latest version of flutter then lable text and hint text shown like this
//         // if you r using flutter less then 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Plus Icon.svg"),
//       ),
//     );
//   }
// }
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
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),

            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),


          DefaultButton(
            text: "완료",
            press: () {
              Navigator.pushNamed(context, CompleteProfileScreen.routeName);
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
