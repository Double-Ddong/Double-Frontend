import 'package:flutter/material.dart';

import 'components/body.dart';

class AuthSchoolScreen2 extends StatelessWidget {
  static String routeName = "/auth_school2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth School"),
      ),
      body: Body(),
    );
  }
}
