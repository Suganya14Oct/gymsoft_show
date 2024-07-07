import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymsoft_show/home_page/main_screen.dart';
import 'package:gymsoft_show/login/login.dart';
import 'package:gymsoft_show/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {

  final User? user;

  const SplashScreen({super.key,this.user});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    getValidationData().whenComplete(() {
      Timer(Duration(seconds: 3), () => Get.to(
          finalEmail == null ?
          LoginScreen()
              : MainScreen()));
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var ObtainedaccesstToken= sharedPreferences.getString('phone');
    setState(() {
      finalEmail = ObtainedaccesstToken;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        color: Colors.black,
        child: Image.asset("assets/gymsoftLogo.png"),
      ),
    );
  }
}
