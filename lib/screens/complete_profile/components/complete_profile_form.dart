import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/components/send_button.dart';
import 'package:shop_app/components/cancel_button.dart';

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
  String? department;
  final departments = ['소프트웨어학과', '경영학과', '법학과', '전자공학과', '전기공학과'];
  String selectedDepartment = '소프트웨어학과';
  final mbtis = ['ENTJ', 'ENTP', 'ENFJ', 'ENFP', 'ESTJ', 'ESTP', 'ESFJ', 'ESFP', 'INTJ', 'INTP', 'INFJ', 'INFP', 'ISTJ', 'ISTP', 'ISFJ', 'ISFP'];
  String selectedMbti = 'ENTJ';
  final areas = ['서울특별시', '부산광역시', '대구광역시', '인천광역시', '광주광역시','울산광역시', '세종특별자치시', '경기도', '강원도', '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주특별자치도'];
  String selectedArea = '서울특별시';
  final heights = ['140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151','152', '153', '154', '155', '156', '157','158', '159', '160', '161', '162', '163','164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175'];
  String selectedHeight = '140';
  final drinks = ['음주를 하지 않음', '적당히 함', '즐김'];
  String selectedDrink = '음주를 하지 않음';
  final smokes = ['비흡연', '흡연'];
  String selectedSmoke = '비흡연';

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
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "학과",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          buildDepartmentFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "MBTI",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          buildMbtiFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "지역",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          buildAreaFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "키",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          buildHeightFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "음주",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          buildDrinkFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            alignment: Alignment(-0.8, 0.0),
            child: Text(
              "흡연",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.005),
          buildSmokeFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "회원가입 완료",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CancelButton(
            text: "취소",
            press: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
              // }
            },
          ),
        ],
      ),
    );
  }

  Center buildSmokeFormField() {
    return Center(
      child: Column(
          children: <Widget> [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black54
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedSmoke,
                onChanged: (String? newValue) =>
                    setState(() => selectedSmoke = newValue!),
                items: smokes
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                    .toList(),
                // add extra sugar..
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,
                underline: SizedBox(),
              ),
            ),
          ]
      ),
    );
  }

  Center buildDrinkFormField() {
    return Center(
      child: Column(
          children: <Widget> [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black54
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDrink,
                onChanged: (String? newValue) =>
                    setState(() => selectedDrink = newValue!),
                items: drinks
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                    .toList(),
                // add extra sugar..
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,
                underline: SizedBox(),
              ),
            ),
          ]
      ),
    );
  }

  Center buildHeightFormField() {
    return Center(
      child: Column(
          children: <Widget> [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black54
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedHeight,
                onChanged: (String? newValue) =>
                    setState(() => selectedHeight = newValue!),
                items: heights
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                    .toList(),
                // add extra sugar..
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,
                underline: SizedBox(),
              ),
            ),
          ]
      ),
    );
  }

  Center buildAreaFormField() {
    return Center(
      child: Column(
          children: <Widget> [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black54
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedArea,
                onChanged: (String? newValue) =>
                    setState(() => selectedArea = newValue!),
                items: areas
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                    .toList(),
                // add extra sugar..
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,
                underline: SizedBox(),
              ),
            ),
          ]
      ),
    );
  }

  Center buildMbtiFormField() {
    return Center(
      child: Column(
          children: <Widget> [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black54
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedMbti,
                onChanged: (String? newValue) =>
                    setState(() => selectedMbti = newValue!),
                items: mbtis
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                    .toList(),
                // add extra sugar..
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,
                underline: SizedBox(),
              ),
            ),
          ]
      ),
    );
  }

  Center buildDepartmentFormField() {
    return Center(
      child: Column(
          children: <Widget> [
            Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.black54
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDepartment,
                onChanged: (String? newValue) =>
                    setState(() => selectedDepartment = newValue!),
                items: departments
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ))
                    .toList(),
                // add extra sugar..
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,
                underline: SizedBox(),
              ),
            ),
          ]
      ),
    );
  }

  Row buildBirthFormField() {
    return Row(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth * 0.65,
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
                      ? _selectedDate.toString().substring(0,10)
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
        birthday = _selectedDate.toString().substring(0,10);
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
