import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/models/Person.dart';

class UserTwo extends StatelessWidget {
  const UserTwo({
    Key? key,
    required this.person,
  }) : super(key: key);
  final Person person;
  @override
  Widget build(BuildContext context) {
    final Person loginperson =
    ModalRoute.of(context)!.settings.arguments as Person;
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child:  Image.network(loginperson.frienddetailfrom.Profile),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: SizedBox(
              height: 60,
              width: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Cookie.svg"),
                //child: AssetImage("assets/icons/cookie.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
