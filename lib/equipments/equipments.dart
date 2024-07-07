import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Equipments extends StatefulWidget {
  const Equipments({super.key});

  @override
  State<Equipments> createState() => _EquipmentsState();
}

class _EquipmentsState extends State<Equipments> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){
      return  Scaffold(
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
                              Text("Equipments",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                            ],
                          )
                      ),
                      Container(
                        height: 85.0.h,
                        //width: width,
                        child: ListView.builder(
                            itemCount: equipment.length,
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
                                            Flexible(child: Text('${equipment[index].name}',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.white
                                            ),)),
                                            Flexible(
                                                flex: 5,
                                                child: Text('${equipment[index].description}',style: TextStyle(
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
                                            child: ClipOval(
                                                child:
                                                Image.asset('${equipment[index].image}',
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
    );
  }
}

class EquipmentShow {
  final String name;
  final String description;
  final String image;

  EquipmentShow({
    required this.name,
    required this.description,
    required this.image,
  });
}

List<EquipmentShow> equipment = [
  EquipmentShow(
      name: 'Chest Press Machine',
      description: "This machine involves you sitting upright and you using your arms to push a load with a weight plate away from your chest and back to where you are.Compared to other types of machines. ",
      image: 'assets/equipment_1.jpg'),
  EquipmentShow(
      name: 'Seated Dip Machine',
      description: "The seated dip machine allows you to enjoy all the benefits of normal bench dips but using a machine that will prevent you from losing your form and balance. You get to sit upright and use your triceps to push the weights down and back up again. ",
      image: 'assets/equipment_2.jpg'),
  EquipmentShow(
      name: 'Chest Fly Machine',
      description: "The chest fly strengthens your chest and torso to allow you to increase muscle mass. It’s a great alternative to work your chest without having to load heavy weights onto a barbell.",
      image: 'assets/equipment_3.jpg'),
  EquipmentShow(
      name: 'Bench Press',
      description: "The bench press is a popular type of gym equipment, especially for those just starting to get into weight lifting. Basically, you lay flat on a padded bench, use a barbell and do push ups. Above the bench is a barbell stand where the barbell will go. ",
      image: 'assets/equipment_4.jpeg'),

];
