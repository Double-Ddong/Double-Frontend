import 'package:flutter/material.dart';

import 'components/body.dart';

class AuthPhoneScreen extends StatelessWidget {
  static String routeName = "/auth_phone";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Phone"),
      ),
      body: Body(),
    );
  }
}
