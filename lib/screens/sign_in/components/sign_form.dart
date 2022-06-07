import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/screens/forgot_id/forgot_id_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/components/Friends/MBTI_friends.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/models/Person.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("자동 로그인"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotIdScreen.routeName),
                child: Text(
                  "아이디 찾기",
                  style: TextStyle(color: kPrimaryColor, decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(10)),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(
                    context, ForgotPwScreen.routeName),
                child: Text(
                  "비밀번호 찾기",
                  style: TextStyle(color: kPrimaryColor,decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "로그인",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                //1. 로그인 하기
                response = await dio.post('http://$apiServer:3000/auth/signin', data: {'Email': email, 'Password': password});
                Map responseBody1 = response.data;
                bool success = responseBody1['success'];

                if(success) {
                  //2. 로그인해서 얻은 userid로 사용자의 프로필 정보
                  String userId = responseBody1['data']['userid'].toString();
                  response = await dio.get('http://$apiServer:3000/main/mainpage3/${userId}');
                  Map responseBody2 = response.data;
                  bool success = responseBody2['success'];

                  if(success) {
                    //3. userid로 사용자의 tab 정보 (받은 쿠키, 보낸 쿠기 수, email)
                    response = await dio.get('http://$apiServer:3000/main/tab/${userId}');
                    Map responseBody3 = response.data;
                    bool success = responseBody3['success'];

                    if(success) {
                      //4. userid로 사용자의 친구범위 정보
                      response = await dio.get('http://$apiServer:3000/setting/getScope/$userId');
                      Map responseBody4 = response.data;
                      bool success = responseBody4['success'];

                      if(success){
                        //5. userid로 친구 정보
                        response = await dio.get('http://$apiServer:3000/main/mainpage2/$userId/1');
                        Map FriendListBody = response.data;
                        bool success = FriendListBody['success'];

                        if(success){
                            //6. userid로 친구 정보2
                            response = await dio.get('http://$apiServer:3000/main/mainpage2/$userId/2');
                            Map FriendListBody2 = response.data;
                            bool success = FriendListBody2['success'];

                            if(success){
                              //7. userid로 친구 정보3
                              response = await dio.get('http://$apiServer:3000/main/mainpage2/$userId/3');
                              Map FriendListBody3 = response.data;
                              bool success = FriendListBody3['success'];
                              if(success){


                                //친구 리스트 1
                                int depart_len = FriendListBody['data'][0].length;
                                List<Friends> Departmentfriends = [];
                                for(int i = 0; i < depart_len; i++){
                                  Friends department = Friends(
                                    FriendListBody['data'][0][i]['UserId'],
                                    FriendListBody['data'][0][i]['Profile'],
                                    FriendListBody['data'][0][i]['NickName'],
                                    Age : FriendListBody['data'][0][i]['Age'],
                                    department : true,
                                  );
                                  Departmentfriends.add(department);
                                }

                                for(int i = 0; i < depart_len; i++){
                                  response = await dio.get('http://$apiServer:3000/main/mainpage3/${Departmentfriends[i].UserId}');
                                  Map FriendListBody10 = response.data;
                                  bool success = FriendListBody10['success'];

                                  if(success){
                                    Departmentfriends[i].University = FriendListBody10['data'][0][0]['University'];
                                    Departmentfriends[i].Department = FriendListBody10['data'][0][0]['Department'];
                                    Departmentfriends[i].MBTI_input = FriendListBody10['data'][0][0]['MBTI'];
                                    Departmentfriends[i].Introduce = FriendListBody10['data'][0][0]['Introduce'];
                                    Departmentfriends[i].Hobby = FriendListBody10['data'][0][0]['Hobby'];
                                    Departmentfriends[i].Location = FriendListBody10['data'][0][0]['Location'];
                                    Departmentfriends[i].Smoke = FriendListBody10['data'][0][0]['Smoke'];
                                    Departmentfriends[i].Drink = FriendListBody10['data'][0][0]['Drink'];
                                  }
                                }
                                //  친구리스트 2
                                int nearby_len = FriendListBody2['data'][0].length;
                                List<Friends> Nearbyfriends = [];
                                for(int i = 0; i < nearby_len; i++){
                                  Friends nearby = Friends(
                                    FriendListBody2['data'][0][i]['UserId'],
                                    FriendListBody2['data'][0][i]['Profile'],
                                    FriendListBody2['data'][0][i]['NickName'],
                                    Age : FriendListBody2['data'][0][i]['Age'],
                                    Nearby : true,
                                  );
                                  Nearbyfriends.add(nearby);
                                  }
                                for(int i = 0; i < nearby_len; i++){
                                  response = await dio.get('http://$apiServer:3000/main/mainpage3/${Nearbyfriends[i].UserId}');
                                  Map FriendListBody20 = response.data;
                                  bool success = FriendListBody20['success'];
                                  if(success){
                                    Nearbyfriends[i].University = FriendListBody20['data'][0][0]['University'];
                                    Nearbyfriends[i].Department = FriendListBody20['data'][0][0]['Department'];
                                    Nearbyfriends[i].MBTI_input = FriendListBody20['data'][0][0]['MBTI'];
                                    Nearbyfriends[i].Introduce = FriendListBody20['data'][0][0]['Introduce'];
                                    Nearbyfriends[i].Hobby = FriendListBody20['data'][0][0]['Hobby'];
                                    Nearbyfriends[i].Location = FriendListBody20['data'][0][0]['Location'];
                                    Nearbyfriends[i].Smoke = FriendListBody20['data'][0][0]['Smoke'];
                                    Nearbyfriends[i].Drink = FriendListBody20['data'][0][0]['Drink'];
                                  }
                                }
                                //  친구리스트3
                                int mbti_len = FriendListBody3['data'][0].length;
                                List<Friends> MBTIfriends = [];
                                for(int i = 0; i < mbti_len; i++){
                                Friends MBTI = Friends(
                                FriendListBody3['data'][0][i]['UserId'],
                                FriendListBody3['data'][0][i]['Profile'],
                                FriendListBody3['data'][0][i]['NickName'],
                                Age : FriendListBody3['data'][0][i]['Age'],
                                MBTI : true,
                                );
                                MBTIfriends.add(MBTI);
                                }
                                for(int i = 0; i < mbti_len; i++){
                                  response = await dio.get('http://$apiServer:3000/main/mainpage3/${MBTIfriends[i].UserId}');
                                  Map FriendListBody30 = response.data;
                                  bool success = FriendListBody30['success'];
                                  if(success){
                                    MBTIfriends[i].University = FriendListBody30['data'][0][0]['University'];
                                    MBTIfriends[i].Department = FriendListBody30['data'][0][0]['Department'];
                                    MBTIfriends[i].MBTI_input = FriendListBody30['data'][0][0]['MBTI'];
                                    MBTIfriends[i].Introduce = FriendListBody30['data'][0][0]['Introduce'];
                                    MBTIfriends[i].Hobby = FriendListBody30['data'][0][0]['Hobby'];
                                    MBTIfriends[i].Location = FriendListBody30['data'][0][0]['Location'];
                                    MBTIfriends[i].Smoke = FriendListBody30['data'][0][0]['Smoke'];
                                    MBTIfriends[i].Drink = FriendListBody30['data'][0][0]['Drink'];
                                  }
                                }
                                response = await dio.get('http://$apiServer:3000/main/cookie/receive/${userId.toString()}');
                                Map FriendListBody200 = response.data;
                                bool success = FriendListBody200['success'];

                                if(success){
                                  response = await dio.get('http://$apiServer:3000/main/cookie/send/${userId.toString()}');
                                  Map FriendListBody100 = response.data;
                                  bool success = FriendListBody100['success'];
                                  //print(FriendListBody100['data'][1][0]['UserId']);

                                  if(success){
                                    int send_len = FriendListBody100['data'][1].length;
                                    List<Friends> SendFriends = [];
                                    for(int i = 0; i < send_len; i++){
                                      Friends send = Friends(
                                        FriendListBody100['data'][1][i]['UserId'],
                                        FriendListBody100['data'][1][i]['Profile'],
                                        FriendListBody100['data'][1][i]['NickName'],

                                        University : FriendListBody100['data'][1][i]['University'],
                                        Department : FriendListBody100['data'][1][i]['Department'],

                                      );
                                      SendFriends.add(send);
                                    }
                                    int receive_len = FriendListBody200['data'][1].length;
                                    List<Friends> Receivefriends = [];
                                    for(int i = 0; i < receive_len; i++){
                                      Friends MBTI = Friends(
                                        FriendListBody200['data'][1][i]['UserId'],
                                        FriendListBody200['data'][1][i]['Profile'],
                                        FriendListBody200['data'][1][i]['NickName'],
                                        University : FriendListBody200['data'][1][i]['University'],
                                        Department : FriendListBody200['data'][1][i]['Department'],
                                      );
                                      Receivefriends.add(MBTI);
                                    }

                                    for(int i = 0; i<send_len;i++){
                                      response = await dio.get('http://$apiServer:3000/main/mainpage3/${SendFriends[i].UserId}');
                                      Map FriendListBody1000 = response.data;
                                      SendFriends[i].MBTI_input = FriendListBody1000['data'][0][0]['MBTI'];
                                      SendFriends[i].Introduce = FriendListBody1000['data'][0][0]['Introduce'];
                                      SendFriends[i].Hobby = FriendListBody1000['data'][0][0]['Hobby'];
                                      SendFriends[i].Location = FriendListBody1000['data'][0][0]['Location'];
                                      SendFriends[i].Smoke = FriendListBody1000['data'][0][0]['Smoke'];
                                      SendFriends[i].Drink = FriendListBody1000['data'][0][0]['Drink'];
                                    }
                                    for(int i = 0; i<receive_len;i++){
                                      response = await dio.get('http://$apiServer:3000/main/mainpage3/${Receivefriends[i].UserId}');
                                      Map FriendListBody2000 = response.data;
                                      Receivefriends[i].MBTI_input = FriendListBody2000['data'][0][0]['MBTI'];
                                      Receivefriends[i].Introduce = FriendListBody2000['data'][0][0]['Introduce'];
                                      Receivefriends[i].Hobby = FriendListBody2000['data'][0][0]['Hobby'];
                                      Receivefriends[i].Location = FriendListBody2000['data'][0][0]['Location'];
                                      Receivefriends[i].Smoke = FriendListBody2000['data'][0][0]['Smoke'];
                                      Receivefriends[i].Drink = FriendListBody2000['data'][0][0]['Drink'];
                                    }



                                    Person loginPerson = Person(
                                        userId.toString(),
                                        responseBody2['data'][0][0]['Profile'], responseBody2['data'][0][0]['NickName'],
                                        responseBody2['data'][0][0]['University'], responseBody2['data'][0][0]['Department'],
                                        responseBody2['data'][0][0]['MBTI'], responseBody2['data'][0][0]['Location'],
                                        responseBody2['data'][0][0]['Smoke'], responseBody2['data'][0][0]['Drink'],
                                        responseBody2['data'][0][0]['Hobby'], responseBody2['data'][0][0]['Introduce'],
                                        responseBody2['data'][0][0]['Age'].toString(), responseBody2['data'][0][0]['Birth'],
                                        responseBody2['data'][0][0]['Phone'].toString(), responseBody2['data'][0][0]['Height'].toString(),
                                        responseBody3['data'][0]['SendCookie'].toString(), responseBody3['data'][0]['ReceiveCookie'].toString(),
                                        responseBody3['data'][0]['Email'], responseBody4['message'][0]['ScopeUniversity'],
                                        responseBody4['message'][0]['ScopePeople'],0,
                                        Receivefriends, SendFriends,
                                        Department: Departmentfriends, Nearby: Nearbyfriends, MBTI: MBTIfriends
                                    );
                                    Navigator.pushNamed(context, LoginSuccessScreen.routeName, arguments: loginPerson);
                                  }

                                }



                              //


                              }
                            }


                            }

                        }


                      }
                    }
                  }
                } else {
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
                                new Text("로그인 실패"),
                              ],
                            ),
                            //
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "ID 혹은 비밀번호가 \n일치하지 않습니다",
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
                }
              }
            ,
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "비밀번호",
        hintText: "비밀번호를 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "이메일",
        hintText: "이메일을 입력하세요",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
