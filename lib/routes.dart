import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth_school2/auth_school_screen2.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/chat/chat_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/forgot_id/forgot_id_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/friends_list/friends_list_screen.dart';
import 'package:shop_app/screens/home/components/cookie.dart';
import 'package:shop_app/screens/home/components/gotcookie.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/setting/setting_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'screens/auth_school/auth_school_screen.dart';
import 'screens/auth_phone/auth_phone_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/view_profile/view_profile_screen.dart';
import 'screens/modify_profile/modify_profile_screen.dart';
import 'screens/scope_setting/scope_setting_screen.dart';
import 'screens/modify_password/modify_password_screen.dart';
import 'screens/delete_account/delete_account_screen.dart';
import 'package:shop_app/screens/match/match_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPwScreen.routeName: (context) => ForgotPwScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  SettingScreen.routeName: (context) => SettingScreen(),
  AuthPhoneScreen.routeName: (context) => AuthPhoneScreen(),
  AuthSchoolScreen.routeName: (context) => AuthSchoolScreen(),
  AuthSchoolScreen2.routeName: (context) => AuthSchoolScreen2(),
  ForgotIdScreen.routeName: (context) => ForgotIdScreen(),
  ViewProfileScreen.routeName: (context) => ViewProfileScreen(),
  ModifyProfileScreen.routeName: (context) => ModifyProfileScreen(),
  ScopeSettingScreen.routeName: (context) => ScopeSettingScreen(),
  ModifyPasswordScreen.routeName: (context) => ModifyPasswordScreen(),
  DeleteAccountScreen.routeName: (context) => DeleteAccountScreen(),
  FriendsListScreen.routeName: (context) => FriendsListScreen(),

  CookieScreen.routeName : (context) => CookieScreen(),
  CookieGotScreen.routeName : (context) => CookieGotScreen(),
  ChatScreen.routeName : (context) => ChatScreen(),

  MatchScreen.routeName: (context) => MatchScreen(),


};
