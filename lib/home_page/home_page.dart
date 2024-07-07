import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/attendance/attendance.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:gymsoft_show/equipments/equipments.dart';
import 'package:gymsoft_show/feedback/feedback.dart';
import 'package:gymsoft_show/notification/notificat.dart';
import 'package:gymsoft_show/plan/plan.dart';
import 'package:gymsoft_show/slot_booking/slot_booking.dart';
import 'package:gymsoft_show/trainer/trainer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

  final token;

  const HomePage({@required this.token, super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {


    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

          return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(66.0),
                child: AppBar(
                  actions: [
                    Row(
                      children: [
                        InkWell(
                          child: Icon(Icons.notifications,color: Colors.white,
                            size: 29.dp,),
                          onTap: (){
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Notificat()));
                            });
                          },
                        ),
                        SizedBox(width: 3.w,),
                        InkWell(
                            onTap: (){
                              setState(() {
                                // _api.logout();
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              });
                            },
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  mainScreenNotifier.pageIndex = 3;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  height: 50.h,
                                  width: 20.w,
                                  //color: Colors.white70,
                                  child: CircleAvatar(
                                      child: ClipOval(
                                          child:
                                          Image.asset('assets/profile_image.png',fit: BoxFit.cover,)
                                      )
                                  )
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                  toolbarHeight: 120,
                  backgroundColor: Colors.black,
                  automaticallyImplyLeading: false,
                  leadingWidth: 55.w,
                  leading: Container(
                    width: width * 0.5,
                    //color: Colors.white70,
                    padding: EdgeInsets.only(top: 16.0),
                    //margin: EdgeInsets.only(top: 10.0),
                    child: Image.asset("assets/gymsoftLogo.png",fit: BoxFit.cover,),
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Container(
                    height: height.h,
                    width: width.w,
                    color: Colors.black,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/male_background.jpeg"),fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 25.h,
                          width: width.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 40.0,left: 25.0,right: 10.0),
                                height: 40.h,
                                width: width * 0.09.w,
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    border: Border.all(
                                        color: Colors.white24
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 0.0),
                                        //child: Text('${get_responcebody!['days_since_joined']}', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 32.0.dp))
                                        child: Text('12', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 32.0.dp))
                                    ),
                                    Text('Completed\n      Days',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),)
                                  ],
                                ),
                              ),
                              Container(
                                height: 40.h,
                                width: width * 0.09.w,
                                margin: EdgeInsets.only(top: 40.0,left: 10.0,right: 25.0),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    border: Border.all(
                                        color: Colors.white24
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 3.7.h,
                                          width: 4.4.w,
                                          margin: EdgeInsets.only(top: 8.0,left: 10.0,right: 5.0),
                                          child: Image.asset("assets/inprogress.png"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8.0),
                                          child: Text("Your Progress",
                                            style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 11.0.dp),),
                                        )
                                      ],
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 10.0,left: 15.0),
                                          child:  Text('Buil Muscle & Weight Gain',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 14.0.dp))
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3.5.h),
                        Divider(
                          color: Colors.white,
                          indent: 13.0.w,
                          endIndent: 5.0.h,
                          thickness: 0.1.h,
                        ),
                        SizedBox(height: 3.5.h),
                        Container(
                          height: 63.h,
                          width: width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 0.0.w,right: 20.0,left: 30.0),
                                      height: 12.h,
                                      width: 24.w,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                              color: Colors.white24
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap : (){
                                              setState(() {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => Attendance()));
                                              });
                                            },
                                            child: Container(
                                              height: 5.h,
                                              width: 16.w,
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Image.asset("assets/attendance.png"),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text('Attendance',
                                              style: TextStyle(color: Colors.white,
                                                  fontFamily: 'Telex',
                                                  fontSize: 10.0.dp),),
                                          )
                                        ],
                                      )
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SlotBooking()));
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 0.0.w,right: 20.0,left: 30.0),
                                        height: 12.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            border: Border.all(
                                                color: Colors.white24
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 16.w,
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Image.asset("assets/slot_booking.png"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Slot Booking',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                            )
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap : (){
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Trainer()));
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                        height: 12.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            border: Border.all(
                                                color: Colors.white24
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 16.w,
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Image.asset("assets/trainer.png"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Trainer',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Equipments()));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                        height: 12.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            border: Border.all(
                                                color: Colors.white24
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 16.w,
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Image.asset("assets/gym_equipment.png"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Equipments',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                            )
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                        height: 12.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            border: Border.all(
                                                color: Colors.white24
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 16.w,
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Image.asset("assets/feedback.png"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Feedback',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Plan()));
                                      });
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                        height: 12.h,
                                        width: 24.w,
                                        decoration: BoxDecoration(
                                            color: Colors.black54,
                                            border: Border.all(
                                                color: Colors.white24
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 5.h,
                                              width: 16.w,
                                              margin: EdgeInsets.only(top: 10.0),
                                              child: Image.asset("assets/planning.png"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0),
                                              child: Text('Plan',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                            )
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
  }
}
