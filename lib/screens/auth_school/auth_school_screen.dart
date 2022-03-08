import 'package:flutter/material.dart';

import 'components/body.dart';

class AuthSchoolScreen extends StatelessWidget {
  static String routeName = "/auth_school";
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
