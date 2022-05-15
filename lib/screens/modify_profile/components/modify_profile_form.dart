import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/view_profile/view_profile_screen.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/components/send_button_small.dart';
import 'dart:io';
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

  String? nickName = '';
  String birth = '1999-08-05';
  String phone = '010-1234-5678';
  DateTime? _selectedDate;
  String? department = '';
  String mbti = '';
  String changeMbti = '';
  String area = '';
  String? height = '158';
  String drink = '즐김';
  String smoke = '비흡연';
  final mbtis = ['ENTJ', 'ENTP', 'ENFJ', 'ENFP', 'ESTJ', 'ESTP', 'ESFJ', 'ESFP', 'INTJ', 'INTP', 'INFJ', 'INFP', 'ISTJ', 'ISTP', 'ISFJ', 'ISFP'];
  final areas = ['강남구', '강동구', '강북구', '강서구', '관악구','구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구','용산구','은평구','종로구','중구','중랑구'];
  final drinks = ['음주를 하지 않음', '적당히 함', '즐김'];
  final smokes = ['비흡연', '흡연'];

  File? _image;
  final _picker = ImagePicker();
  String sendimage= '';

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

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        sendimage = pickedImage.path;
      });
    }
    else{
      sendimage = 'assets/images/Profile Image.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Person args = ModalRoute.of(context)?.settings.arguments as Person;
    nickName = args.nickname;
    //birth = args.birth;
    //phone = args.phone;
    department = args.department;
    area = args.location;
    //height = args.height;
    //drink = args.drink;
    smoke = args.smoke;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  icon: SvgPicture.asset("assets/icons/Back ICon.svg"),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, ViewProfileScreen.routeName, arguments: args);
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
          image(args),
          //ProfilePic(),
          SizedBox(height: getProportionateScreenHeight(30)),
          //buildNameFormField(),
          //SizedBox(height: getProportionateScreenHeight(20)),
          buildNickNameFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildBirthFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDepartmentFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildMBTIFormField(args),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildAreaFormField(args),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildHeightFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildDrinkFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildSmokeFormField(args),
        ],
      ),
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
                print(nickName);
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
        initialDate:DateTime.now(),
        firstDate:DateTime(1900),
        lastDate:DateTime.now())
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
          width: getProportionateScreenWidth(45),
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
        SizedBox(width: getProportionateScreenWidth(30)),
        Container(
          width: getProportionateScreenWidth(240),
          height: getProportionateScreenHeight(50),
          //alignment: Alignment(0.0, 1.0),
          child:
          TextFormField(
            initialValue: department,
            onSaved: (newValue) => department = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kDepartmentNullError);
              } else if (value.length <= 15) {
                removeError(error: kLongDepartmentError);
              }
              department = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kDepartmentNullError);
                return "";
              } else if (value.length > 15) {
                addError(error: kLongDepartmentError);
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

  Row buildMBTIFormField(Person args) {
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
              value: args.mbti,
              onChanged: (String? newValue) =>
                  setState(() {
                    args.mbti = newValue!;
                  }),
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

  Row buildAreaFormField(Person args) {
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
              value: args.location,
              onChanged: (String? newValue) =>
                  setState(() => args.location = newValue!),
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
          width: getProportionateScreenWidth(45),
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
        SizedBox(width: getProportionateScreenWidth(30)),
        Container(
          width: getProportionateScreenWidth(240),
          height: getProportionateScreenHeight(50),
          //alignment: Alignment(0.0, 1.0),
          child:
          TextFormField(
            keyboardType: TextInputType.phone,
            initialValue: height,
            onSaved: (newValue) => height = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kHeightNullError);
              } else if (value.length <= 4) {
                removeError(error: kLongHeightError);
              }
              height = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kHeightNullError);
                return "";
              } else if (value.length > 4) {
                addError(error: kLongHeightError);
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

  Row buildSmokeFormField(Person args) {
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
              value: args.smoke,
              onChanged: (String? newValue) =>
                  setState(() => args.smoke = newValue!),
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

  Widget image(Person args) {
    return SizedBox(
      height: getProportionateScreenHeight(200),
      width: getProportionateScreenWidth(200),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            width: getProportionateScreenWidth(200),
            height: getProportionateScreenHeight(200),
            child: _image != null
                ? Image.file(_image!, fit: BoxFit.fill)
                : Image.network(args.profile),
          ),
          Positioned(
            right: -16,
            bottom: -5,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: _openImagePicker,
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

