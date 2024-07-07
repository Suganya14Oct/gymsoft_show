import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:gymsoft_show/profile/edit_profile.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  double minValue = 0.0;
  double maxValue = 100.0;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){

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
                            image: AssetImage("assets/male_background.jpeg"),fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                Container(
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        height: 40.h,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0.w),
                                bottomLeft: Radius.circular(10.0.w)
                            )
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap : (){
                                    setState(() {
                                      print('Navigating');
                                      mainScreenNotifier.pageIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 10.0.h,
                                      width: 10.0.w,
                                      child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20.dp,)
                                  ),
                                ),
                                Text("Profile",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10.0,right: 15.0,),
                                  height: 100,
                                  width: 100,
                                  child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          print('from profile');
                                        });
                                      },
                                      child: CircleAvatar(
                                          child: ClipOval(
                                              child:
                                              Image.asset('assets/profile_image.png',fit: BoxFit.cover,)
                                          )
                                      )
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Text('Stell Ruth',
                                            overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 30.0.dp))
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.05,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.monitor_weight,color: Colors.white,size: 35.dp,),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child:  Text('75 Kgs', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.height,color: Colors.white,size: 35.dp,),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text('165 Cms',
                                            style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.perm_contact_calendar_sharp,color: Colors.white,size: 35.dp,),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text('23 Yrs',
                                            style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 5.5.h,
                                      width: 11.5.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 1.5
                                          )
                                      ),
                                      child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text('12',
                                              style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text('Days',style: TextStyle(color: Colors.white,fontSize: 11.dp),),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        height: height * 0.06,
                        width: width * 0.8,
                        alignment: Alignment.center,
                        child: Text('Your Progress',style: TextStyle(color: Colors.white,fontSize: 25.dp),),
                      ),
                       Container(
                        height: height * 0.3,
                        width: width * 0.7,
                        //color: Colors.white70,
                        child: SfRadialGauge(
                          //backgroundColor: Colors.white10,
                          axes: [
                            RadialAxis(
                              // minimum: get_responcebody != null
                              //     ? '${get_responcebody!['initial_weight']}'
                              //     : 0,
                              minimum: minValue,
                              maximum: maxValue,
                              // startAngle: 180,
                              // endAngle: 360,
                              axisLineStyle: AxisLineStyle(
                                  thicknessUnit: GaugeSizeUnit.factor,thickness: 0.03
                              ),
                              minorTickStyle: MinorTickStyle(length: 3,thickness: 3,color: Colors.white),
                              majorTickStyle: MajorTickStyle(length: 6,thickness: 4,color: Colors.white),
                              axisLabelStyle:GaugeTextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                              useRangeColorForAxis: true,
                              ranges: [
                                // GaugeRange(
                                //   startValue: lossSegmentMin,
                                //   endValue: lossSegmentMax,
                                //   color: Colors.red,
                                //   // startWidth: 0.05,
                                //   // endWidth: 25,
                                //   gradient: const SweepGradient(
                                //       colors: <Color>[Color(0xFFBC4E9C), Color(0xFFF80759)],
                                //       stops: <double>[0.25, 0.75]),
                                // ),
                                // GaugeRange(
                                //   startValue: neutralSegmentMin,
                                //   endValue: neutralSegmentMax,
                                //   color: Colors.yellow,
                                //   // startWidth: 0.05,
                                //   // endWidth: 25,
                                //   gradient: const SweepGradient(
                                //       colors: <Color>[Colors.orangeAccent, Colors.yellow],
                                //       stops: <double>[0.25, 0.75]),
                                // ),
                                // GaugeRange(
                                //   startValue: gainSegmentMin,
                                //   endValue: gainSegmentMax,
                                //   color: Colors.green,
                                //   // startWidth: 0.05,
                                //   // endWidth: 25,
                                //   gradient: const SweepGradient(
                                //       colors: <Color>[Colors.red,Colors.yellow, Colors.green],
                                //       stops: <double>[0.25, 0.95,0.150]),
                                // )
                              ],
                              pointers: [
                                NeedlePointer(
                                  value: maxValue,
                                  enableAnimation: true,
                                  needleColor: Colors.white,
                                ),
                                MarkerPointer(
                                  value: maxValue,
                                  enableAnimation: true,
                                  color: Colors.black,
                                )
                              ],
                              annotations: [
                                GaugeAnnotation(
                                  widget: Text('Kgs/days',style: TextStyle(color: Colors.lightGreenAccent),),
                                  positionFactor: 0.55,
                                  angle: 85,
                                )
                              ],
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xffB3AFAF),Color(0xffFFFFFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Icon(Icons.mode_edit_outline_rounded,size: 24.dp),
                      ),
                    )
                )
              ],
            ),
          )
      );
    }

    );
  }
}