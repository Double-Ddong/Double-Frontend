import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/cookie.dart';

import '../../../size_config.dart';
import 'gotcookie.dart';

class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          UserAccountsDrawerHeader(
            // currentAccountPicture: CircleAvatar(
            //   child: ClipOval(
            //     child: Image.network("https://randomuser.me/api/portraits/women/14.jpg"),
            //   ),
            // ),

              accountName: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // height : 10,
                    // width: 10,
                    // alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/logo.png"
                            )
                        ),
                      )
                  ),
                  SizedBox(height: getProportionateScreenWidth(15)),
                  Text(
                      '보똥이',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black)),
                ],
              ),
              accountEmail: null,

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