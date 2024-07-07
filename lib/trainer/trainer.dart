import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Trainer extends StatefulWidget {
  const Trainer({super.key});

  @override
  State<Trainer> createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {

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
                        image: AssetImage("assets/female_bg.jpg"),fit: BoxFit.cover
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
                            Text("Trainer",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                          ],
                        )
                    ),
                    Container(
                      height: 85.0.h,
                      //width: width,
                      child: ListView.builder(
                          itemCount: trainers.length,
                          itemBuilder: (BuildContext context, int index){
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 60),
                                  width: MediaQuery.of(context).size.width,
                                  height: 25.0.h,
                                  //color: Colors.black,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.black45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Flexible(child: Text('${trainers[index].name}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.white
                                          ),)),
                                          Flexible(
                                              flex: 5,
                                              child: Text('${trainers[index].description}',style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.0.dp,
                                                  color: Colors.white
                                              ),)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 35.0.dp,left: 5.0,
                                    child: Container(
                                        width: 110,
                                        height: 110,
                                        child: CircleAvatar(
                                            child:  ClipOval(
                                                child:
                                                Image.asset('${trainers[index].image}',
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
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

class TrainerShow {
  final String name;
  final String description;
  final String image;

  TrainerShow({
    required this.name,
    required this.description,
    required this.image,
  });
}

List<TrainerShow> trainers = [
  TrainerShow(
      name: 'Lily George',
      description: "She's a health and performance specialist with a background in competitive volleyball. Her coaching and specialism was inspired by a sporting injury and her journey to recovery. Lily works with both end of the athlete spectrum. ",
      image: 'assets/trainer_1.webp'),
  TrainerShow(
      name: 'Scott Laidler',
      description: "Scott is regularly asked to feature as a consultant in fitness magazines and write a regular column in The Telegraph on maintaining a healthy lifestyle.",
      image: 'assets/trainer_3.jpg'),
  TrainerShow(
      name: 'Joe Dowdell',
      description: "Joe is another celebrity trainer with 25+ years of experience in the fitness industry. He started as a model in his early adult life, traveling around the world before settling back in NYC and opening his on gym.After Joe had to close the physical gym he launched his online platform called Dowdell Fitness Systems to deliver proven fitness and personalized nutrition plans to clients.",
      image: 'assets/trainer_2.jpg'),
  TrainerShow(
      name: 'Alexia Clark',
      description: "Alexia is an online female fitness coach who provides new daily workouts, nutrition support and direct one to one accountability if you need it. Her goal is for you to feel constantly challenged and stimulated by your workouts.Not just physically, but mentally too.",
      image: 'assets/trainer_5.jpg'),

];
