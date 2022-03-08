import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPwScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot pw"),
      ),
      body: Body(),
    );
  }
}
