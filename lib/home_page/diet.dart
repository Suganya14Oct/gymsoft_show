import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class Diet extends StatefulWidget {
  const Diet({super.key});

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {

  List<bool> chechBoxStates = [false, false, false];

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      print('Navigating');
                                      mainScreenNotifier.pageIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 10.0.h,
                                      width: 10.0.w,
                                      child: Icon(
                                        Icons.arrow_back_ios, color: Colors.white,
                                        size: 20.dp,)
                                  ),
                                ),
                                Text("Diet",style: TextStyle(color: Colors.white,fontSize: 25.dp ))
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 3.6.h,
                                  width: 4.4.w,
                                  margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                  child: Image.asset("assets/item.png"),
                                ),
                                Flexible(
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 6.0,top: 8.0),
                                        child: Text("Today's Diet Plan for you",
                                          style: TextStyle(color: Colors.white,
                                              fontFamily: 'Telex',fontSize: 15.0.dp))
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 85.0.h,
                              child: ListView.builder(
                                        itemCount: 3,
                                        itemBuilder: (BuildContext context, int index){

                                          return Column(
                                            children: [
                                              Container(
                                                width: width,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Text('Recommended Breakfast',
                                                    style: TextStyle(color: Colors.white,
                                                        fontFamily: 'Telex',fontSize: 12.0.dp)
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 18.h,
                                                    width: 80.w,
                                                    margin: EdgeInsets.only(top: 12.0, right: 10.0,left: 13.0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black54,
                                                        border: Border.all(
                                                            color: Colors.white10
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 3.6.h,
                                                              width: 4.4.w,
                                                              margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                              child: Image.asset("assets/clock.png"),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 8.0),
                                                              child: Text("Time - 9 : 00 am",
                                                                style: TextStyle(color: Colors.white,
                                                                    fontFamily: 'Telex',fontSize: 12.0.dp)),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height: 3.6.h,
                                                              width: 4.4.w,
                                                              margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                              child: Image.asset("assets/item.png"),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 8.0),
                                                              child: Text("Items : ",
                                                                  style: TextStyle(color: Colors.white,
                                                                      fontFamily: 'Telex',fontSize: 12.0.dp)),
                                                            ),
                                                            Container(
                                                              height: 13.h,
                                                              width: 50.w,
                                                              child: Flex(
                                                                direction: Axis.vertical,
                                                                children: [
                                                                  Flexible(
                                                                    flex: 7,
                                                                    child: Center(
                                                                      child: FittedBox(
                                                                        child: Text('Items - Egg White(2), Oats(200g)',
                                                                          style: TextStyle(color: Colors.white,
                                                                              fontFamily: 'Telex',fontSize: 12.0.dp),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Transform.scale(
                                                    scale: 1.3,
                                                    child: Checkbox(
                                                      checkColor: Colors.black,
                                                      autofocus: true,
                                                      focusColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8.0)
                                                      ),
                                                      side: BorderSide(
                                                          color: Colors.white
                                                      ),
                                                      activeColor: Colors.white,
                                                      value: chechBoxStates[index],
                                                      onChanged: (value)  {
                                                         setState(() {
                                                           chechBoxStates[index] = value!;
                                                         });
                                                      },
                                                      visualDensity: VisualDensity.adaptivePlatformDensity,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          );
                                        })
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}