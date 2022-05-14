import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';
import 'package:shop_app/screens/home/components/cookie.dart';
import '../../../size_config.dart';
import 'gotcookie.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class NavBar extends StatelessWidget {

  late Response response;
  var dio = Dio();

  String NickName = '';
  String Profile = '';
  String Email = '';
  late int SendCookie = 0;
  late int ReceiveCookie = 0;

  void getMyInfo(final userId) async {
    try {
      response = await dio.get('http://13.125.168.216:3000/main/tab/${userId}');
      Map responseBody = response.data;
      bool success = responseBody['success'];

      if (success) {
        Profile = responseBody['data'][0]['Profile'];
        NickName = responseBody['data'][0]['NickName'];
        Email = responseBody['data'][0]['Email'];
        SendCookie = responseBody['data'][0]['SendCookie'];
        ReceiveCookie = responseBody['data'][0]['ReceiveCookie'];
      }

    } catch(e) { print(e); }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments;
    getMyInfo(userId);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture:
            CircleAvatar(
              backgroundImage: Profile.isNotEmpty ? NetworkImage(Profile) : null,
            ),
            accountName:
            Text(
              NickName,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail:
            Text(
              Email,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            decoration: BoxDecoration(),
          ),
          Column(
              children : [
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('받은 쿠키 (${ReceiveCookie})'),
                  onTap: () {
                    Navigator.pushNamed(context, CookieGotScreen.routeName);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('보낸 쿠키 (${SendCookie})'),
                    onTap: () {
                      Navigator.pushNamed(context, CookieScreen.routeName);
                    }
                ),
              ]
          ),
          Divider(),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('홈'),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routeName, arguments: userId);
            },
          ),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('채팅'),
            onTap: () {
              Navigator.pushNamed(context, ChatScreen.routeName, arguments: userId);
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