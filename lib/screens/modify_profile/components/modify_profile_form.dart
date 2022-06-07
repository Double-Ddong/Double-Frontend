import 'dart:math';

import 'package:dio/dio.dart';
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
  DateTime? _selectedDate;
  final mbtis = ['ENTJ', 'ENTP', 'ENFJ', 'ENFP', 'ESTJ', 'ESTP', 'ESFJ', 'ESFP', 'INTJ', 'INTP', 'INFJ', 'INFP', 'ISTJ', 'ISTP', 'ISFJ', 'ISFP'];
  final areas = ['강남구', '강동구', '강북구', '강서구', '관악구','구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구','용산구','은평구','종로구','중구','중랑구'];
  final drinks = ['음주를 하지 않음', '적당히 함', '즐김'];
  final smokes = ['비흡연', '흡연'];

  File? _image;
  final _picker = ImagePicker();
  String sendimage= '';

  late Response response;
  var dio = Dio();

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
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;

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
                        context, ViewProfileScreen.routeName, arguments: loginPerson);
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    dio.options.contentType = 'multipart/form-data';
                    dio.options.maxRedirects.isFinite;

                    var formData3 = FormData.fromMap({
                      "img": await MultipartFile.fromFile(sendimage, filename: 'upload.png'),
                      "NickName": loginPerson.nickname,
                      "Birth": loginPerson.birth,
                      "Department": loginPerson.department,
                      'MBTI': loginPerson.mbti,
                      'Location': loginPerson.location,
                      'Height': loginPerson.height,
                      'Drink': loginPerson.drink,
                      'Smoke': loginPerson.smoke,
                      'Hobby': loginPerson.hobby,
                      'Introduce': loginPerson.introduce,
                    });

                    response = await dio.post(
                        'http://$apiServer:3000/setting/modifyProfile/${loginPerson.userid}',
                        data: formData3
                    );

                    Map responseBody = response.data;
                    bool success = responseBody['success'];

                    if(success){
                      loginPerson.profile = responseBody['data'];
                      Navigator.pushNamed(context, SettingScreen.routeName, arguments: loginPerson);
                    }

                  }
                }
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          image(loginPerson),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildNickNameFormField(loginPerson),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildBirthFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDepartmentFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildMBTIFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildAreaFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildHeightFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildDrinkFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildSmokeFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildHobbyFormField(loginPerson),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildIntroduceFormField(loginPerson),
        ],
      ),
    );
  }

  Row buildNickNameFormField(Person loginPerson) {
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
              initialValue: loginPerson.nickname,
              onSaved: (newValue) => loginPerson.nickname = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kNickNameNullError);
                } else if (value.length <= 10) {
                  removeError(error: kLongNickNameError);
                }
                loginPerson.nickname = value;
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

  Row buildBirthFormField(Person loginPerson) {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
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
            loginPerson.birth,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.18,//double.infinity,
          height: SizeConfig.screenHeight * 0.05,
          child: TextButton(
            style: TextButton.styleFrom(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              primary: Colors.white,
              backgroundColor: kPrimaryColor,
            ),
            onPressed : () {
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
                  loginPerson.birth = _selectedDate.toString().substring(0,10);
                });
              });
            },
            child: Text(
              '선택',
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // void _presentDatePicker() {
  //   // showDatePicker is a pre-made funtion of Flutter
  //   showDatePicker(
  //       context: context,
  //       initialDate:DateTime.now(),
  //       firstDate:DateTime(1900),
  //       lastDate:DateTime.now())
  //       .then((pickedDate) {
  //     // Check if no date is selected
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       // using state so that the UI will be rerendered when date is picked
  //       _selectedDate = pickedDate;
  //       birth = _selectedDate.toString().substring(0,10);
  //     });
  //   });
  // }

  Row buildPhoneFormField(Person loginPerson) {
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
            loginPerson.phone,
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

  Row buildDepartmentFormField(Person loginPerson) {
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
            initialValue: loginPerson.department,
            onSaved: (newValue) => loginPerson.department = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kDepartmentNullError);
              } else if (value.length <= 15) {
                removeError(error: kLongDepartmentError);
              }
              loginPerson.department = value;
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

  Row buildMBTIFormField(Person loginPerson) {
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
              value: loginPerson.mbti,
              onChanged: (String? newValue) =>
                  setState(() {
                    loginPerson.mbti = newValue!;
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

  Row buildAreaFormField(Person loginPerson) {
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
              value: loginPerson.location,
              onChanged: (String? newValue) =>
                  setState(() => loginPerson.location = newValue!),
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

  Row buildHeightFormField(Person loginPerson) {
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
            initialValue: loginPerson.height,
            onSaved: (newValue) => loginPerson.height = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kHeightNullError);
              } else if (value.length <= 4) {
                removeError(error: kLongHeightError);
              }
              loginPerson.height = value;
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

  Row buildDrinkFormField(Person loginPerson) {
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
              value: loginPerson.drink,
              onChanged: (String? newValue) =>
                  setState(() => loginPerson.drink = newValue!),
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

  Row buildSmokeFormField(Person loginPerson) {
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
              value: loginPerson.smoke,
              onChanged: (String? newValue) =>
                  setState(() => loginPerson.smoke = newValue!),
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

  Widget image(Person loginPerson) {
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
                : Image.network(loginPerson.profile),
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

  Row buildHobbyFormField(Person loginPerson) {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          width: getProportionateScreenWidth(45),
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            "취미",
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
            initialValue: loginPerson.hobby,
            onSaved: (newValue) => loginPerson.hobby = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kHobbyNullError);
              } else if (value.length <= 30) {
                removeError(error: kLongHobbyError);
              }
              loginPerson.hobby = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kHobbyNullError);
                return "";
              } else if (value.length > 30) {
                addError(error: kLongHobbyError);
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
  
  Row buildIntroduceFormField(Person loginPerson) {
    return Row(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(20)),
        Container(
          width: getProportionateScreenWidth(65),
          //alignment: Alignment(-0.9, 0.0),
          child: Text(
            "자기소개",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(15)),
        Container(
          width: getProportionateScreenWidth(230),
          height: getProportionateScreenHeight(50),
          //alignment: Alignment(0.0, 1.0),
          child:
          TextFormField(
            initialValue: loginPerson.introduce,
            onSaved: (newValue) => loginPerson.introduce = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kIntroduceNullError);
              } else if (value.length <= 30) {
                removeError(error: kLongIntroduceError);
              }
              loginPerson.nickname = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kIntroduceNullError);
                return "";
              } else if (value.length > 30) {
                addError(error: kLongIntroduceError);
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
}

