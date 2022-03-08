import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen2 extends StatelessWidget {
  static String routeName = "/complete_profile2";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(),
    );
  }
}
