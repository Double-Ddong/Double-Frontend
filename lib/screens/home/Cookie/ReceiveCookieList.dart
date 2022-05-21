import 'package:flutter/material.dart';
import 'package:shop_app/models/Person.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/home/Cookie/CookieDetail/CookieDetailScreen.dart';
// import 'package:shop_app/screens/setting/components/profile_pic.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ReceiveCookieList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final Person loginperson =
    ModalRoute.of(context)!.settings.arguments as Person;
    // TODO: implement build
    return
      Scaffold(
        body: Center(
          child: GridView.builder(
            // scrollDirection: Axis.vertical,
            // shrinkWrap: true,
              itemCount: loginperson.Receive.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 4 / 1,
              ),
              itemBuilder: (BuildContext context, int i) {
                return _tile(context, loginperson, i,loginperson.Receive[i].NickName, loginperson.Receive[i].Age.toString() ,
                    loginperson.Receive[i].University , loginperson.Receive[i].Department, loginperson.Receive[i].Profile);
              })
        ),
      );
  }


}

ListTile _tile(BuildContext context, Person p, int i,String title, String subtitle1, String subtitle2, String subtitle3, String img) => ListTile(

    title: Text(title),
    subtitle: Row(
        children : [
          Container(
            width: SizeConfig.screenWidth * 0.08,
            height: 27,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              subtitle1,
              style: TextStyle(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Container(
            width: SizeConfig.screenWidth * 0.2,
            height: 25,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(subtitle2,
              style: TextStyle(height: 1.5),
              textAlign: TextAlign.center,),
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Container(
            width: SizeConfig.screenWidth * 0.3,
            height: 25,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(subtitle3,
              style: TextStyle(height: 1.5),
              textAlign: TextAlign.center,),
          ),
        ]
    ) ,
    // Text(subtitle1),
    leading: ClipRRect(
      borderRadius : BorderRadius.circular(100),
      child: Image.network(img),
    ),
  onTap: () {
    p.frienddetailfrom = p.Receive[i];
    Navigator.pushNamed(context, DetailsScreen.routeName, arguments: p);
    },
);
