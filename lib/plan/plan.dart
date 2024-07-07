import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/plan/buy_plan.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                      height: 10.0.h,
                      child: Row(
                        children: [
                          InkWell(
                            onTap : (){
                              setState(() {
                                print('Navigating');
                                // mainScreenNotifier.pageIndex = 0;
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                height: 10.0.h,
                                width: 10.0.w,
                                child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20.dp,)
                            ),
                          ),
                          Text("Plan",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                        ],
                      )
                  ),
                  Container(
                    height: 85.0.h,
                    child: ListView.builder(
                        itemCount: planshow.length,
                        itemBuilder: (BuildContext context, int index){
                          return Stack(
                            children: [
                              InkWell(
                                onTap : (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPlan(
                                      img: planshow[index].image,
                                      desc: planshow[index].small_desc,
                                      b_desc: planshow[index].brief_desc,
                                    )));
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 60),
                                  width: MediaQuery.of(context).size.width,
                                  height: 20.0.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.black45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Center(
                                                child: Text('${planshow[index].description}',
                                                  style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0.dp,
                                                  color: Colors.white
                                                                                            ),),
                                              )),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Flexible(
                                                  child: Text('₹ ${planshow[index].price}',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.0.dp,
                                                      color: Colors.white
                                                  ),)),
                                              Flexible(
                                                  child: Text('View',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0.dp,
                                                      color: Colors.white
                                                  ),)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 23.0.dp,left: 5.0,
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      child: CircleAvatar(
                                          child:  ClipOval(
                                              child:
                                              Image.asset('${planshow[index].image}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace){
                                                  print('Error loading image: $error');
                                                  return SizedBox(
                                                    height: 2.h,
                                                    width: 4.w,
                                                    child: CircularProgressIndicator(color: Colors.black12),
                                                  );
                                                },
                                              )
                                          )
                                      )
                                  )
                              )
                            ],
                          );
                        })
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlanShow {
  final String price;
  final String description;
  final String image;
  final String brief_desc;
  final String small_desc;

  PlanShow({
    required this.price,
    required this.description,
    required this.image,
    required this.brief_desc,
    required this.small_desc
  });
}

List<PlanShow> planshow = [
  PlanShow(
      price: '999',
      description: "Big and Strong: 8 Week Advanced Strength Building Workout",
      image: 'assets/plan_6.webp',
      brief_desc: 'The beginner gains people see when they first start training are always enjoyable. It makes us want to do more, lift more, and feel even more powerful. The downside is that eventually, the gains may stall and what previously worked may not be as effective.',
      small_desc: "8 Week Advanced Strength Building Workout"
  ),
  PlanShow(
      price: '834',
      description: "Jamal Browner’s 2-Day Deadlifting Program: Deadlift 1,000+ Lbs",
      image: 'assets/plan_1.jpg',
      brief_desc: "In the realm of strength training, no exercise carries the same weight of respect and admiration as the deadlift. This foundational movement isn't just about lifting a heavy barbell off the ground—it's a test of grit, technique, and sheer power.",
      small_desc: " Deadlift 1,000+ Lbs"
  ),
  PlanShow(
      price: '833',
      description: "Sculpted Strength: The Ultimate 12 Week Bodybuilding Program",
      image: 'assets/plan_2.webp',
      brief_desc: 'This program includes six days of workouts with a focus on each muscle group. The workouts will take about 60-90 minutes including the time you take to warm up and prepare.You should rest anywhere from 60-90 seconds between sets and keep transition time from one exercise to the other to a minimum.',
      small_desc: 'The Ultimate 12 Week Bodybuilding Program'
  ),
  PlanShow(
      price: '900',
      description: "Dumbbell Only Workout: 5 Day Dumbbell Workout Split",
      image: 'assets/plan_3.jpg',
      brief_desc: "The workout can be performed for up to 12 weeks.After 12 weeks, you may want to consider increasing the volume within the workout, the weight of the dumbbells you are using, or look into facilities that offer more of a variety of weighted equipment.",
      small_desc: '5 Day Dumbbell Workout Split'
  ),
  PlanShow(
      price: '900',
      description: "6 Day Push/Pull/Legs (PPL) Powerbuilding Workout Split & Meal Plan",
      image: 'assets/plan_4.jpg',
      brief_desc: "Each workout starts out with a compound lift using a 15 rep goal over 5 sets. If you exceed the rep goal by 0-3 reps then add 2.5-5lbs to the working weight the next time you perform the exercise. If you exceed the rep goal by 4+ reps then add 5-10lbs to the working weight.",
      small_desc: 'Powerbuilding Workout Split & Meal Plan'
  ),
  PlanShow(
      price: '900',
      description: "4 Day Maximum Mass Workout",
      image: 'assets/plan_5.jpg',
      brief_desc: "For each body part you will perform a 5 minute burn out period. These sets are brutal. Pick a weight that allows you to perform about 12-15 reps. Over a 5 minute period you perform as many reps as possible with that weight, starting and stopping sets as needed. Rest only long enough to catch your bearings and breathe, and then start knowing out more reps.",
      small_desc: '4 Day Maximum Mass Workout'
  ),

];
