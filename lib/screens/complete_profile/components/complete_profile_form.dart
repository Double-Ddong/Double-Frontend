import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/components/send_button.dart';
import 'package:shop_app/components/cancel_button.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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
  String? height;
  String? hobby;
  String? introduce;
  final mbtis = ['ENTJ', 'ENTP', 'ENFJ', 'ENFP', 'ESTJ', 'ESTP', 'ESFJ', 'ESFP', 'INTJ', 'INTP', 'INFJ', 'INFP', 'ISTJ', 'ISTP', 'ISFJ', 'ISFP'];
  String selectedMbti = 'ENTJ';
  final areas = ['강남구', '강동구', '강북구', '강서구', '관악구','구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구','용산구','은평구','종로구','중구','중랑구'];
  String selectedArea = '강남구';
  final drinks = ['음주를 하지 않음', '적당히 함', '즐김'];
  String selectedDrink = '음주를 하지 않음';
  final smokes = ['비흡연', '흡연'];
  String selectedSmoke = '비흡연';
  DateTime? _selectedDate;
  late Response response;
  var dio = Dio();
  File? _image;
  final _picker = ImagePicker();
  String sendimage= '';
  File? _image2 = File("assets/images/Profile Image.png");

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
    final userId = ModalRoute.of(context)?.settings.arguments;
    print(userId);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          image(),
          SizedBox(height: getProportionateScreenHeight(40)),
          buildNickNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGenderFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBirthFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
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
          SizedBox(height: getProportionateScreenHeight(30)),
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
          SizedBox(height: getProportionateScreenHeight(30)),
          buildHobbyFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildIntroduceFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "회원가입 완료",
            press: () async {
              if (_formKey.currentState!.validate()) {
                response = await dio.post(
                    'http://$apiServer:3000/auth/signupProfile/${userId}',
                    data: {
                      'NickName': nickName,
                      'Sex': genderMode,
                      'Birth': birthday,
                      'Department': department,
                      'Mbti': selectedMbti,
                      'Location': selectedArea,
                      'Height': height,
                      'Drink': selectedDrink,
                      'Smoke': selectedSmoke,
                      'Hobby': hobby,
                      'Introduce': introduce
                    });
                Map responseBody = response.data;
                bool success = responseBody['success'];

                if (success) {
                  if(_image == null) {
                    void FlutterDialog() {
                      showDialog(
                          context: context,
                          //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              //Dialog Main Title
                              title: Column(
                                children: <Widget>[
                                  new Text("회원가입 실패"),
                                ],
                              ),
                              //
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "프로필 사진을 선택해주세요.",
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("확인"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    }
                    FlutterDialog();
                  } else {
                    dio.options.contentType = 'multipart/form-data';
                    dio.options.maxRedirects.isFinite;

                    var formData3 = FormData.fromMap({
                      "img": await MultipartFile.fromFile(sendimage,filename: 'upload.png')
                    });
                    response = await dio.post(
                        'http://$apiServer:3000/auth/signupProfileImg/${userId}',
                        data: formData3
                    );
                    print(response.data);
                    Map responseBody2 = response.data;
                    bool success2 = responseBody2['success'];

                    if (success2) {
                      //Navigator.pushNamed(context, SignInScreen.routeName);
                    }
                  }
                }
              }


            },
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          CancelButton(
            text: "취소",
            press: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
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

  TextFormField buildDepartmentFormField() {
    return TextFormField(
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
        labelText: "학과",
        hintText: "학과를 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildHeightFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
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
        labelText: "키",
        hintText: "키를 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildHobbyFormField() {
    return TextFormField(
      onSaved: (newValue) => hobby = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kHobbyNullError);
        } else if (value.length <= 30) {
          removeError(error: kLongHobbyError);
        }
        hobby = value;
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
        labelText: "취미",
        hintText: "취미를 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildIntroduceFormField() {
    return TextFormField(
      onSaved: (newValue) => introduce = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kIntroduceNullError);
        } else if (value.length <= 30) {
          removeError(error: kLongIntroduceError);
        }
        introduce = value;
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
        labelText: "자기소개",
        hintText: "자신을 소개해주세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget image() {
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
                : const Text('프로필 사진을 선택해주세요'),
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

// _uploadImage() async {
//   var formData = FormData.fromMap({
//     "image" : await MultipartFile.fromFile(imageFile!.path)
//   });
//   var response = await Dio
// }