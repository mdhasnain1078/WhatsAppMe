import 'package:flutter/material.dart';
import 'package:whatsappme/common/model/user_model.dart';
import 'package:whatsappme/feature/auth/pages/login_page.dart';
import 'package:whatsappme/feature/auth/pages/user_info_page.dart';
import 'package:whatsappme/feature/auth/pages/varification_page.dart';
import 'package:whatsappme/feature/chats/pages/chat_page.dart';
import 'package:whatsappme/feature/chats/pages/profile_page.dart';
import 'package:whatsappme/feature/contect/page/contect_page.dart';
import 'package:whatsappme/feature/home/page/home_page.dart';
import 'package:whatsappme/feature/welcom/pages/welcom_page.dart';

class Routes{

  static const String welcome = "welcome";
  static const String login = "login";
  static const String userInfo = "user-info";
  static const String verification = "verification";
  static const String home = "home";
  static const String contact = "contact";
  static const String chat = "chat";
  static const String profile = "profile";

  static Route<dynamic> onGeneratedRoute(RouteSettings settings){
    switch(settings.name){
      case welcome:
        return MaterialPageRoute(builder: (context)=>const WelcomePage());
      case login:
        return MaterialPageRoute(builder: (context)=>const LoginPage());
      case userInfo:
        final String? profileImageUrl = settings.arguments as String?;
        return MaterialPageRoute(builder: (context)=>UserInfoPage(profileImageUrl:profileImageUrl));
      case home:
        return MaterialPageRoute(builder: (context)=>const HomePage());
      case contact:
        return MaterialPageRoute(builder: (context)=>const ContectPage());
      case chat:
        final UserModel userModel = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context)=>ChatPage(user: userModel,));
      case profile:
        final UserModel  userModel = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context)=>ProfilePage(user: userModel,));
      case verification:
        final Map arg = settings.arguments as Map;  
        return MaterialPageRoute(builder: (context)=> VarificationPage(smsCodeId: arg["smsCodeId"], phoneNumber: arg["phoneNumber"],));
      default:
         return MaterialPageRoute(builder: (context)=>const Scaffold(body: Center(child: Text("No route foound for the page"),),));
    }
  }
}