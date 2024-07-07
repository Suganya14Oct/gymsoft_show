import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:gymsoft_show/login/login.dart';
import 'package:gymsoft_show/profile/edit_profile.dart';
import 'package:gymsoft_show/settings/about_us.dart';
import 'package:gymsoft_show/settings/change_password.dart';
import 'package:gymsoft_show/settings/privacy_policy.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child){
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    color: Colors.black,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/male_background.jpeg"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  Container(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  print('Navigating');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                  mainScreenNotifier.pageIndex = 0;
                                });
                              },
                              child:  Container(
                                  alignment: Alignment.centerRight,
                                  height: 10.0.h,
                                  width: 10.0.w,
                                  child: Icon(
                                    Icons.arrow_back_ios, color: Colors.white,
                                    size: 20.dp)
                              ),
                            ),
                            Text("Settings",style: TextStyle(color: Colors.white,fontSize: 25.dp))
                          ],
                        ),
                        SizedBox(
                          height: 12.5.h,
                        ),
                        Container(
                          height: 6.h,
                          width: width,
                         // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                height: 4.h,
                                width: 20.w,
                                //color: Colors.black45,
                                child: Image.asset('assets/edit_profile.png')
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                               // color: Colors.black,
                                child: Text('Edit Profile',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/change_password.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Change Password',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/logout.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Log Out',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(32.0))
                                        ),
                                        title: Center(
                                          child: Text('Log Out?', style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Telex',
                                              //fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                        content: Text('Are you sure you want to Log Out?',style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Telex',
                                          //fontWeight: FontWeight.bold
                                        ),),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                 height: 6.h,
                                                width: 25.w,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffd41012)), // Set the background color here
                                                    ),
                                                    onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: Text('Cancel',
                                                  style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontWeight: FontWeight.bold),)),
                                              ),
                                              Container(
                                                height: 6.h,
                                                width: 25.w,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), // Set the background color here
                                                    ),
                                                    onPressed: () async {
                                                      final SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
                                                      sharedPrefereces.remove('phone');
                                                      print("Success");
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                                                    }, child: Text('Log Out',
                                                  style: TextStyle(color: Colors.black,fontFamily: 'Telex',
                                                     // fontWeight: FontWeight.bold
                                                  ),)),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/about_us.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('About Us',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/privacy_policy.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Privacy Policy',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
