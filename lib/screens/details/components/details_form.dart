import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button_half.dart';
import 'package:shop_app/components/cancel_button_half.dart';
import 'package:shop_app/components/mail_text.dart';
import 'package:shop_app/models/Chat.dart';
import 'package:shop_app/models/ChatMessage.dart';
import 'package:shop_app/models/Friends.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/match/match_screen.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';
import 'package:shop_app/screens/messages/message_screen.dart';

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

        Row(children: [
          SizedBox(width: getProportionateScreenWidth(5)),
          OutlinedButton(
            onPressed: () => {},
            child: Text(
              "${f.Age.toString()}세",
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
          ) ,
          SizedBox(width: getProportionateScreenWidth(5)),
        ],),
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(5)),
            OutlinedButton(
              onPressed: () => {},
              child: Text(
                f.Location.toString(),
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
                f.MBTI_input.toString(),
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
                f.Smoke.toString(),
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
            )
            ,
          ],
        ),
        SizedBox(height: getProportionateScreenHeight(10)),
        Row(children: [
          SizedBox(width: getProportionateScreenWidth(5)),
          OutlinedButton(
            onPressed: () => {},
            child: Text(
              f.Drink.toString(),
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
        ],),
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(15)),
            DefaultButtonHalf(
              text: "쿠키 보내기",
              press: () async {

                response = await dio.post('http://$apiServer:3000/main/sendCookie/${p.userid}',data: {'userid' : f.UserId});

                Map FriendListBody100 = response.data;
                // print(FriendListBody100);
                bool success = FriendListBody100['success'];

                if(!success){
                  if(FriendListBody100['message'][0] == "쿠키를 전에 보냈습니다."){
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
                                  new Text("알림"),
                                ],
                              ),
                              //
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "전에 쿠키를 보냈습니다.",
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
                if(success){

                  // if(FriendListBody100['message'][0] == "쿠키를 전에 보냈습니다."){
                  //   void FlutterDialog() {
                  //     showDialog(
                  //         context: context,
                  //         //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                  //         barrierDismissible: false,
                  //         builder: (BuildContext context) {
                  //           return AlertDialog(
                  //             // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                  //             shape: RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(10.0)),
                  //             //Dialog Main Title
                  //             title: Column(
                  //               children: <Widget>[
                  //                 new Text("알림"),
                  //               ],
                  //             ),
                  //             //
                  //             content: Column(
                  //               mainAxisSize: MainAxisSize.min,
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: <Widget>[
                  //                 Text(
                  //                   "전에 쿠키를 보냈습니다.",
                  //                 ),
                  //               ],
                  //             ),
                  //             actions: <Widget>[
                  //               new FlatButton(
                  //                 child: new Text("확인"),
                  //                 onPressed: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         });
                  //   }
                  //   FlutterDialog();
                  //
                  // }
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
                    //쿠키 개수 업데이트
                    response = await dio.get('http://$apiServer:3000/main/tab/${p.userid}');
                    Map ResponseBody = response.data;
                    p.sendCookie = ResponseBody['data'][0]['SendCookie'].toString();
                    //보낸쿠키 친구 리스트 업데이트
                    response = await dio.get('http://$apiServer:3000/main/mainpage3/${f.UserId}');
                    Map FriendListBody1000 = response.data;
                    Friends friend = Friends(
                      f.UserId,
                      FriendListBody1000['data'][0][0]['Profile'],
                      FriendListBody1000['data'][0][0]['NickName'],
                      Age: FriendListBody1000['data'][0][0]['Age'],
                      University : FriendListBody1000['data'][0][0]['University'],
                      Department : FriendListBody1000['data'][0][0]['Department'],
                      MBTI_input : FriendListBody1000['data'][0][0]['MBTI'],
                      Introduce : FriendListBody1000['data'][0][0]['Introduce'],
                      Hobby : FriendListBody1000['data'][0][0]['Hobby'],

                    );
                    friend.Location = FriendListBody1000['data'][0][0]['Location'];
                    friend.Smoke = FriendListBody1000['data'][0][0]['Smoke'];
                    friend.Drink = FriendListBody1000['data'][0][0]['Drink'];
                    p.Send.add(friend);

                    FlutterDialog();
                  }
                  else{
                    response = await dio.get('http://$apiServer:3000/main/tab/${p.userid}');
                    Map ResponseBody = response.data;
                    p.sendCookie = ResponseBody['data'][0]['SendCookie'].toString();
                    // 보낸쿠기 친구리스트 업데이트
                    //보낸쿠키 친구 리스트 업데이트
                    response = await dio.get('http://$apiServer:3000/main/mainpage3/${f.UserId}');
                    Map FriendListBody1000 = response.data;
                    Friends friend = Friends(
                      f.UserId,
                      FriendListBody1000['data'][0][0]['Profile'],
                      FriendListBody1000['data'][0][0]['NickName'],
                      Age: FriendListBody1000['data'][0][0]['Age'],
                      University : FriendListBody1000['data'][0][0]['University'],
                      Department : FriendListBody1000['data'][0][0]['Department'],
                      MBTI_input : FriendListBody1000['data'][0][0]['MBTI'],
                      Introduce : FriendListBody1000['data'][0][0]['Introduce'],
                      Hobby : FriendListBody1000['data'][0][0]['Hobby'],
                    );
                    friend.Location = FriendListBody1000['data'][0][0]['Location'];
                    friend.Smoke = FriendListBody1000['data'][0][0]['Smoke'];
                    friend.Drink = FriendListBody1000['data'][0][0]['Drink'];
                    p.Send.add(friend);
                    // for(int i = 0;i<p.Receive.length;i++ ){
                    //   if(p.Receive[i].UserId == f.UserId){
                    //     p.Receive.removeAt(i);
                    //   }
                    // }


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
              press: () async {
                //매치 확인하기
                response = await dio.get('http://$apiServer:3000/main/cookie/match/${p.userid}/${f.UserId}');
                Map ResponseBody = response.data;
                bool success = ResponseBody['success'];
                if(success){
                  if(ResponseBody['message'][0] == "매치가 안된 상태"){
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
                                  new Text("알림"),
                                ],
                              ),
                              //
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "서로 쿠키를 보낸 상태가 되면 \n 채팅방이 개설됩니다.",
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
                    response = await dio.get('http://$apiServer:3000/chat/getChatList/${p.userid}');
                    Map responseBody = response.data;
                    bool success = responseBody['success'];

                    if (success) {
                      List<Chat> chatsData = [];
                      List<ChatMessage> Messages = [];
                      int chatlen = responseBody['message'][0];

                      for(int i=0; i<chatlen; i++) {
                        int messagelen = responseBody['message'][1][i].length;
                        Chat chat = Chat();
                        for(int j=0; j<messagelen; j++) {
                          String sendWho = responseBody['message'][1][i][j]['NickName'];
                          if(sendWho == p.nickname) { // 로그인 사용자가 보낸 경우
                            ChatMessage message = ChatMessage(isSender: true);
                            message.text = responseBody['message'][1][i][j]['Message'];
                            message.chatRoom = responseBody['message'][1][i][j]['ChatRoom'];
                            message.userId = responseBody['message'][1][i][j]['UserId'].toString();
                            Messages.add(message);
                            chat.lastMessage = responseBody['message'][1][i][j]['Message'];
                            chat.time = responseBody['message'][1][i][j]['Minute'];
                            if(chat.time >= 1440) {
                              chat.date = responseBody['message'][1][i][j]['Date'];
                            } else {
                              chat.date = 'no date';
                            }
                          } else { // 로그인 사용자가 받은 경우
                            ChatMessage message = ChatMessage(isSender: false);
                            message.text = responseBody['message'][1][i][j]['Message'];
                            message.chatRoom = responseBody['message'][1][i][j]['ChatRoom'];
                            Messages.add(message);
                            chat.name = responseBody['message'][1][i][j]['NickName'];
                            chat.image = responseBody['message'][1][i][j]['Profile'];
                            chat.chatRoom = responseBody['message'][1][i][j]['ChatRoom'];
                            chat.userId = responseBody['message'][1][i][j]['UserId'].toString();
                            chat.lastMessage = responseBody['message'][1][i][j]['Message'];
                            chat.time = responseBody['message'][1][i][j]['Minute'];
                            if(chat.time >= 1440) {
                              chat.date = responseBody['message'][1][i][j]['Date'];
                            } else {
                              chat.date = 'no date';
                            }
                          }
                        }
                        chatsData.add(chat);
                      }
                      p.LastChat = chatsData;
                      p.Message = Messages;

                      Navigator.pushNamed(context, ChatScreen.routeName, arguments: p);
                    }
                  }
                }

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

