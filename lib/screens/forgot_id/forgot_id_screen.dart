import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotIdScreen extends StatelessWidget {
  static String routeName = "/forgot_id";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot id"),
      ),
      body: Body(),
    );
  }
}
