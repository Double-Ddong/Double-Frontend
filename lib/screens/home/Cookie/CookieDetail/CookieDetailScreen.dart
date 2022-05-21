import 'package:shop_app/models/Person.dart';

import 'components/body.dart';
import 'package:flutter/material.dart';
class CookieDetailsScreen extends StatelessWidget {
  static String routeName = "/cookiedetails";

  @override
  Widget build(BuildContext context) {
    final Person loginperson =
        ModalRoute.of(context)!.settings.arguments as Person;
    return Scaffold(
      //backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(23.0),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      //body: Body(product: agrs.product),
      body: Body(),
    );
  }
}
