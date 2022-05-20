import 'package:flutter/material.dart';
import 'package:shop_app/models/Friends.dart';

class Person {
  late String userid, nickname, profile, university, department, mbti, location, smoke, drink, hobby, introduce, birth, phone, email;
  late String age, height, sendCookie, receiveCookie;
  late int scopeUniversity, scopePeople;
  late List<Friends> Department;
  late List<Friends> Nearby;
  late List<Friends> MBTI;

  Person(this.userid, this.profile, this.nickname, this.university, this.department, this.mbti, this.location,
      this.smoke, this.drink, this.hobby, this.introduce, this.age, this.birth, this.phone, this.height,
      this.sendCookie, this.receiveCookie, this.email, this.scopeUniversity, this.scopePeople,
      {
        required this.Department,
        required this.Nearby,
        required this.MBTI,
      }
      );
}
// class LogInPerson {
//   late final int? userid;
//   late final String? profile;
//
//   LogInPerson(String? userId, String? profile, {
//     required this.userid,
//     required this.profile
//   });

  // factory LogInPerson.fromJson(Map <String, dynamic> json){
  //   return LogInPerson(
  //     userid: int.parse(json['userid']),
  //   );
  // }
  //
  // Map<String, dynamic> toJson() =>
  //     {'userid' : userid};
//}

// class testPerson {
//   late final String userId, nickName, profile;
//   late int sendCookie, receiveCookie;
// // final List<String> images;
// // final List<int> sendCookie;
// // final List<int> receiveCookie;
//
//   Person(String userId, String, nickName, String, profile, int sendCookie, int receiveCookie{
//     required this.userId,
//     required this.nickName,
//     required this.profile,
//     required this.sendCookie,
//     required this.receiveCookie
//   });
// }

// class Person {
//   late final String userId, name, nickName, age, university, department, mbti, area, height, smoke, drink;
//   final List<String> images;
//   final List<int> sendCookie;
//   final List<int> receiveCookie;
//
//   // Person({
//   //   required this.userId,
//   //   required this.images,
//   //   required this.sendCookie,
//   //   required this.receiveCookie,
//   //   required this.name,
//   //   required this.nickName,
//   //   required this.age,
//   //   required this.university,
//   //   required this.department,
//   //   required this.mbti,
//   //   required this.area,
//   //   required this.height,
//   //   required this.smoke,
//   //   required this.drink,
//   // });
// }

// Our demo Products
//
// List<Person> demoPersons = [
//   Person(
//     id: 1,
//     images: [
//       "assets/images/ps4_console_white_1.png",
//       "assets/images/ps4_console_white_2.png",
//       "assets/images/ps4_console_white_3.png",
//       "assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Wireless Controller for PS4™",
//     price: 64.99,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     images: [
//       "assets/images/Image Popular Product 2.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Nike Sport White - Man Pant",
//     price: 50.5,
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/glap.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Gloves XC Omega - Polygon",
//     price: 36.55,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Logitech Head",
//     price: 20.20,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//   ),
// ];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
