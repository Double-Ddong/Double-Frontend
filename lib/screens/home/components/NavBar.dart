import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';
import 'package:shop_app/screens/home/components/cookie.dart';
import '../../../size_config.dart';
import 'gotcookie.dart';
import 'package:shop_app/models/Chat.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class NavBar extends StatelessWidget {

  late Response response;
  var dio = Dio();

  @override
  Widget build(BuildContext context) {
    //final userId = ModalRoute.of(context)?.settings.arguments;
    final Person loginPerson = ModalRoute.of(context)?.settings.arguments as Person;
    //getMyInfo(userId);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture:
            CircleAvatar(
              backgroundImage: loginPerson.profile.isNotEmpty ? NetworkImage(loginPerson.profile) : null,
            ),
            accountName:
            Text(
              loginPerson.nickname,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail:
            Text(
              loginPerson.email,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            decoration: BoxDecoration(),
          ),
          Column(
              children : [
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('받은 쿠키 (${loginPerson.receiveCookie})'),
                  onTap: () {
                    Navigator.pushNamed(context, CookieGotScreen.routeName, arguments: loginPerson);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('보낸 쿠키 (${loginPerson.sendCookie})'),
                    onTap: () {
                      Navigator.pushNamed(context, CookieScreen.routeName, arguments: loginPerson);
                    }
                ),
              ]
          ),
          Divider(),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('홈'),
            onTap: ()  {
              Navigator.pushNamed(context, HomeScreen.routeName, arguments: loginPerson);
            },
          ),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('채팅'),
            onTap: () async {
              response = await dio.get('http://13.125.168.216:3000/chat/getChatList/${loginPerson.userid}');
              Map responseBody = response.data;
              bool success = responseBody['success'];

              if (success) {
                List<Chat> chatsData = [];
                int chatlen = responseBody['message'][0];

                for(int i=0; i<chatlen; i++) {
                  Chat chat = Chat();
                  chat.name = responseBody['message'][1][i][(responseBody['message'][1][i].length)-1]['NickName'];
                  chat.image = responseBody['message'][1][i][(responseBody['message'][1][i].length)-1]['Profile'];
                  chat.lastMessage = responseBody['message'][1][i][(responseBody['message'][1][i].length)-1]['Message'];
                  chat.time = responseBody['message'][1][i][(responseBody['message'][1][i].length)-1]['Date'];
                  chatsData.add(chat);
                  loginPerson.LastChat = chatsData;
                }

                Navigator.pushNamed(context, ChatScreen.routeName, arguments: loginPerson);
              }

            },
          ),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('자유게시판'),
            onTap: () => null,
          ),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('간단 MBTI 검사'),
            onTap: () => null,
          )
        ],
      ),
    );
  }
}