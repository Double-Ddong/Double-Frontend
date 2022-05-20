import 'package:flutter/material.dart';

class Friends {
  late int UserId, Age;
  late String Profile, NickName;
  late String University, Department, MBTI_input, Introduce,Hobby;
  final bool department,Nearby, MBTI, isPopular;

  Friends(
    this.UserId, this.Profile, this.NickName,
    {
      this.Age = 0,
      this.University = '',
      this.Department = '',
      this.department = false,
      this.Nearby = false,
      this.MBTI = false,
      this.isPopular = false,
    }
        );
}