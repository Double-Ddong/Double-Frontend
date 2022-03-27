import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/cookie.dart';

import 'gotcookie.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        // padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        children: [
          UserAccountsDrawerHeader(
              accountName: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                      // color: Colors.white,
                      //   borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/logo.png"
                            )
                        ),
                      )
                  ),
                  Text(
                      '보똥이',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              accountEmail: Text('980926a@gmail.com'),

            decoration: BoxDecoration(

            ),

          ),
          Column(
            children : [
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('받은 쿠키'),
                onTap: () {
                  Navigator.pushNamed(context, CookieGotScreen.routeName);
                },
          ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('보낸 쿠키'),
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
            onTap: () => null,
          ),
          ListTile(
            // leading: Icon(Icons.favorite),
            title: Text('채팅'),
            onTap: () => null,
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