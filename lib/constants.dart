import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

const kPrimaryColor = Color(0xFFFF9211);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kSchoolNullError = "학교를 입력해주세요";
const String kIdNullError = "아이디를 입력해주세요";
const String kEmailNullError = "이메일을 입력해주세요";
const String kInvalidEmailError = "유효한 이메일을 입력해주세요";
const String kPassNullError = "비밀번호를 입력해주세요";
const String kShortPassError = "패스워드 길이가 너무 짧습니다";
const String kMatchPassError = "패스워드가 일치하지 않습니다.";
const String kNamelNullError = "이름을 입력해주세요";
const String kNickNameNullError = "닉네임을 입력해주세요";
const String kLongNickNameError = "닉네임 길이가 너무 깁니다";
const String kPhoneNumberNullError = "핸드폰 번호를 입력해주세요";
const String kAddressNullError = "주소를 입력해주세요";
const String kAuthPhoneNullError = "인증번호를 입력해주세요";
const String kMatchAuthPhoneError = "인증번호가 일치하지 않습니다";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
