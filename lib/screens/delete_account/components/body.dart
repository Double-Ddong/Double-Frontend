import 'package:flutter/material.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/complete_profile/components/complete_profile_form.dart';
import 'package:shop_app/screens/forgot_id/components/forgot_id_form.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import 'delete_account_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      SizedBox(
        width: double.infinity,
        child:
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
              Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: getProportionateScreenWidth(12),),
                IconButton(
                  icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                  onPressed: () {
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  }
              ),
                SizedBox(width: getProportionateScreenWidth(90),),

                Container(
                  alignment: Alignment(-0.0, 0.0),
                  child: Text(
                  "회원 탈퇴",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
              ),

                ],
              ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),

                Container(
                  alignment: Alignment(-0.1, 0.0),
                  child: Text(
                    "서비스를 이용해 주셔서 감사합니다.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                Container(
                  alignment: Alignment(-0.5, 0.0),
                  child: Text(
                    "개인정보는 안전하게 삭제됩니다.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(14),
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                DefaultButton(
                  text: "탈퇴",
                  press: () {
                    // if (_formKey.currentState!.validate()) {
                    // _formKey.currentState!.save();
                    // // if all are valid then go to success screen
                    Navigator.pushNamed(context, SignInScreen.routeName);
                    // }
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                CancelButton(
                  text: "취소",
                  press: () {

                    Navigator.pushNamed(context, SettingScreen.routeName);

                  },

                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),


      ),
    );
    //
    //   SingleChildScrollView(
    //   //padding: EdgeInsets.symmetric(vertical: 1),
    //   child: Column(
    //     children: [
    //       Row(
    //         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             SizedBox(width: getProportionateScreenWidth(12),),
    //             IconButton(
    //                 icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
    //                 onPressed: () {
    //                   Navigator.pushNamed(context, SettingScreen.routeName);
    //                 }
    //             ),
    //             SizedBox(width: getProportionateScreenWidth(100),),
    //             Container(
    //               alignment: Alignment(-0.8, 0.0),
    //               child: Text(
    //                 "회원 탈퇴",
    //                 textAlign: TextAlign.left,
    //                 style: TextStyle(
    //                   fontSize: getProportionateScreenWidth(15),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(height: SizeConfig.screenHeight * 0.04),
    //             // ForgotIdForm(),
    //             // CompleteProfileForm(),
    //             // DeleteAccountForm(),
    //             DefaultButton(
    //             text: "완료",
    //             press: () {
    //             // if (_formKey.currentState!.validate()) {
    //             // _formKey.currentState!.save();
    //             // // if all are valid then go to success screen
    //             // Navigator.pushNamed(context, SignInScreen.routeName);
    //             // }
    //             },
    //             ),
    //             SizedBox(height: getProportionateScreenHeight(10)),
    //             CancelButton(
    //             text: "취소",
    //             press: () {
    //             // if (_formKey.currentState!.validate()) {
    //             // {  _formKey.currentState!.save();
    //             // if all are valid then go to success screen
    //             // Navigator.pushNamed(context, SignInScreen.routeName);
    //             // }
    //             },
    //
    //       ),
    //     ],
    //   ),
    // );
  }
}
