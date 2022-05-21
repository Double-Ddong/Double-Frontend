import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button_half.dart';
import 'package:shop_app/components/cancel_button_half.dart';
import 'package:shop_app/components/mail_text.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/match/match_screen.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../details_screen.dart';
late Response response;
var dio = Dio();
class ViewProfileForm extends StatefulWidget {
  @override
  _ViewProfileFormState createState() => _ViewProfileFormState();
}

class _ViewProfileFormState extends State<ViewProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  //bool universityMode = false;  // true - 같은 대학교 소개, false - 다른 대학교 소개
  //bool personMode = false; // true - 아는 사람 차단, false - 아른 사람 차단 X
  bool isMatch = true; // true - match 성공, false - match 아직 안됨

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
    final Person loginperson =
    ModalRoute.of(context)!.settings.arguments as Person;
    // final Friends friend =
    // ModalRoute.of(context)!.settings.arguments as Friends;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildProfileImageFormField(loginperson.frienddetailfrom),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProfileFormField(loginperson.frienddetailfrom, loginperson),
        ],
      ),
    );
  }

  Center buildProfileImageFormField(Friends f) {
    return Center(
      child:
      Image.network(f.Profile,
          width: getProportionateScreenWidth(300),
          height: getProportionateScreenHeight(300)),
    );
  }

  Column buildProfileFormField(Friends f, Person p) {
    return Column(
      children: <Widget> [
        SizedBox(width: getProportionateScreenWidth(10)),
        Container(
          alignment: Alignment.center,
          child: Text(
            f.NickName,
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: [
            // SizedBox(width: getProportionateScreenWidth(15)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                f.Age.toString(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                f.University,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                f.Department,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                f.Age.toString(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style:
              OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  )
              ),
            ),
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(15)),
            DefaultButtonHalf(
              text: "쿠키 보내기",
              press: () async {
                response = await dio.post('http://13.125.168.216:3000/main/sendCookie/${p.userid}',data: {'userid' : f.UserId});
                Map FriendListBody100 = response.data;
                bool success = FriendListBody100['success'];
                if(success){
                  if(FriendListBody100['message'] == "쿠키를 보냈습니다, 매치는 안된 상태."){
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
                                  new Text("쿠키 전송완료!"),
                                ],
                              ),
                              //
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "상대방도 쿠키를 보내면 \n채팅방이 개설됩니다!",
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
                  else{
                    Navigator.pushNamed(context, MatchScreen.routeName, arguments: p);
                  }
                }

                // if (isMatch) {
                //   Navigator.pushNamed(context, MatchScreen.routeName);
                // } else {
                //
                // }
              },
            ),
            SizedBox(width: getProportionateScreenWidth(8)),
            CancelButtonHalf(
              text: "채팅하기",
              press: () {
                Navigator.pushNamed(context, ChatScreen.routeName);
              },
            )
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          alignment: Alignment(-0.8, 0.0),
          child: Text(
            "자기소개",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          alignment: Alignment.center,
          child: Text(
            f.Introduce,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Container(
          alignment: Alignment(-0.8, 0.0),
          child: Text(
            "취미",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(15),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(8)),
        Container(
          alignment: Alignment.center,
          child: Text(
            f.Hobby,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
            ),
          ),
        ),
      ],
    );
  }
}

