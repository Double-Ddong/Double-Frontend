import 'package:flutter/material.dart';

import 'components/body.dart';

class SchoolVaildateScreen extends StatelessWidget {
  static String routeName = "/school_vaildate";
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
