import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/screens/view_profile/view_profile_screen.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/send_button_small.dart';

import 'profile_pic.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ModifyProfileForm extends StatefulWidget {
  @override
  _ModifyProfileFormState createState() => _ModifyProfileFormState();
}

class _ModifyProfileFormState extends State<ModifyProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  String name = '사용자이름';
  String? nickName = 'oeckikek';
  String birth = '1999-08-05';
  String phone = '010-1234-5678';
  DateTime? _selectedDate;
  String department = '소프트웨어학과';
  String mbti = 'ENTJ';
  String area = '서울특별시';
  String height = '150';
  String drink = '즐김';
  String smoke = '비흡연';
  final departments = ['소프트웨어학과', '경영학과', '법학과', '전자공학과', '전기공학과'];
  final mbtis = ['ENTJ', 'ENTP', 'ENFJ', 'ENFP', 'ESTJ', 'ESTP', 'ESFJ', 'ESFP', 'INTJ', 'INTP', 'INFJ', 'INFP', 'ISTJ', 'ISTP', 'ISFJ', 'ISFP'];
  final areas = ['서울특별시', '부산광역시', '대구광역시', '인천광역시', '광주광역시','울산광역시', '세종특별자치시', '경기도', '강원도', '충청북도', '충청남도', '전라북도', '전라남도', '경상북도', '경상남도', '제주특별자치도'];
  final heights = ['140', '141', '142', '143', '144', '145', '146', '147', '148', '149', '150', '151','152', '153', '154', '155', '156', '157','158', '159', '160', '161', '162', '163','164', '165', '166', '167', '168', '169', '170', '171', '172', '173', '174', '175'];
  final drinks = ['음주를 하지 않음', '적당히 함', '즐김'];
  final smokes = ['비흡연', '흡연'];

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
          Row(
            children: [
              //SizedBox(width: getProportionateScreenWidth(5),),
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                  onPressed: () {
                    Navigator.pushNamed(context, ViewProfileScreen.routeName);
                  }
              ),
              SizedBox(width: getProportionateScreenWidth(80),),
              Container(
                alignment: Alignment(-0.8, 0.0),
                child: Text(
                  "프로필 수정",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                  ),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(50),),
              TextButton(
                child: Text(
                  "저장",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionateScreenWidth(18),
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // if all are valid then go to success screen
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ProfilePic(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildNickNameFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildBirthFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDepartmentFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildMBTIFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildAreaFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildHeightFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildDrinkFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildSmokeFormField(),
        ],
      ),
    );
  }

  Row buildNameFormField() {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          width: getProportionateScreenWidth(120),
          height: getProportionateScreenHeight(30),
          alignment: Alignment(-1.0, 0.0),
          child: Text(
            "이름",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row buildNickNameFormField() {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          width: getProportionateScreenWidth(45),
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            "닉네임",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(30)),
        Container(
          width: getProportionateScreenWidth(240),
          height: getProportionateScreenHeight(50),
          //alignment: Alignment(0.0, 1.0),
          child:
            TextFormField(
              initialValue: nickName,
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
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(color: Colors.white),
                ),
              ),
            ),
        ),
      ],
    );
  }

  Row buildBirthFormField() {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            "생년월일",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(60)),
        Container(
          width: getProportionateScreenWidth(100),
          height: getProportionateScreenHeight(20),
          child: Text(
            birth,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),
        //SizedBox(width: getProportionateScreenWidth(30)),
        SendButtonSMALL(
          text: "선택",
          press: _presentDatePicker,
        ),
      ],
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
        birth = _selectedDate.toString().substring(0,10);
      });
    });
  }

  Row buildPhoneFormField() {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            "핸드폰번호",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(45)),
        Container(
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            phone,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row buildDepartmentFormField() {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          width: getProportionateScreenWidth(100),
          height: getProportionateScreenHeight(30),
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            "학과",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          width: getProportionateScreenWidth(180),
          child: DropdownButton<String>(
              isExpanded: true,
              value: department,
              onChanged: (String? newValue) =>
                  setState(() => department = newValue!),
              items: departments
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(15),
                        //fontWeight: FontWeight.bold,
                      ),
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
    );
  }

  Row buildMBTIFormField() {
    return Row(
        children: <Widget> [
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(30),
            //alignment: Alignment(-0.9, 0.0),
            child: Text(
              "MBTI",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(15),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(180),
            child: DropdownButton<String>(
              isExpanded: true,
              value: mbti,
              onChanged: (String? newValue) =>
                  setState(() => mbti = newValue!),
              items: mbtis
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(15),
                        //fontWeight: FontWeight.bold,
                      ),
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
    );
  }

  Row buildAreaFormField() {
    return Row(
        children: <Widget> [
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(30),
            //alignment: Alignment(-0.9, 0.0),
            child: Text(
              "지역",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(15),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(180),
            child: DropdownButton<String>(
              isExpanded: true,
              value: area,
              onChanged: (String? newValue) =>
                  setState(() => area = newValue!),
              items: areas
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(15),
                        //fontWeight: FontWeight.bold,
                      ),
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
    );
  }

  Row buildHeightFormField() {
    return Row(
        children: <Widget> [
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(30),
            //alignment: Alignment(-0.9, 0.0),
            child: Text(
              "키",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(15),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(180),
            child: DropdownButton<String>(
              isExpanded: true,
              value: height,
              onChanged: (String? newValue) =>
                  setState(() => height = newValue!),
              items: heights
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(15),
                        //fontWeight: FontWeight.bold,
                      ),
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
    );
  }

  Row buildDrinkFormField() {
    return Row(
        children: <Widget> [
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(30),
            //alignment: Alignment(-0.9, 0.0),
            child: Text(
              "음주",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(15),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(180),
            child: DropdownButton<String>(
              isExpanded: true,
              value: drink,
              onChanged: (String? newValue) =>
                  setState(() => drink = newValue!),
              items: drinks
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(15),
                        //fontWeight: FontWeight.bold,
                      ),
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
    );
  }

  Row buildSmokeFormField() {
    return Row(
        children: <Widget> [
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(30),
            //alignment: Alignment(-0.9, 0.0),
            child: Text(
              "흡연",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(15),
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Container(
            width: getProportionateScreenWidth(180),
            child: DropdownButton<String>(
              isExpanded: true,
              value: smoke,
              onChanged: (String? newValue) =>
                  setState(() => smoke = newValue!),
              items: smokes
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(15),
                        //fontWeight: FontWeight.bold,
                      ),
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
    );
  }
}

