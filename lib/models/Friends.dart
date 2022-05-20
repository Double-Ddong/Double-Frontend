import 'package:flutter/material.dart';

class Friends {
  late int UserId, Age;
  late String Profile, NickName;
  final bool department,Nearby, MBTI, isPopular;

  Friends(
    this.UserId, this.Profile, this.NickName, this.Age,
    {
      this.department = false,
      this.Nearby = false,
      this.MBTI = false,
      this.isPopular = false,
    }
        );
}