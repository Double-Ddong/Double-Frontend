import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserOne extends StatelessWidget {
  const UserOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset("assets/images/Profile Image Basic.png"),
          ),
          Positioned(
            left: -20,
            top: -20,
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