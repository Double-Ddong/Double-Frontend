import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import 'components/body.dart';

class ScopeSettingScreen extends StatelessWidget {
  static String routeName = "/scope_setting";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(23.0),
        child: AppBar(
          automaticallyImplyLeading: false,
        ),
      ),
      body: Body(),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.setting),
    );
  }
}
