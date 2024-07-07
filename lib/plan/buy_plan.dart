import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/payment/payment.dart';

class BuyPlan extends StatefulWidget {

   final String img;
   final String desc;
   final String b_desc;

   const BuyPlan({required this.img, required this.desc, required this.b_desc, super.key});

  @override
  State<BuyPlan> createState() => _BuyPlanState();
}

class _BuyPlanState extends State<BuyPlan> {

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                color: Colors.black,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/female_blur_bg.jpg"),fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Container(
                height: height,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text("Buy Plan",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                          ],
                        )
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.0),
                      //color: Colors.amber,
                      child: FittedBox(
                        child: Text('${widget.desc}',
                            overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              fontSize: 15.0.dp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 300,
                      padding: EdgeInsets.only(left: 65.0),
                      decoration: BoxDecoration(
                        //color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.asset(
                          '${widget.img}',
                      fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      height: 20.h,
                      alignment: Alignment.center,
                      width: 87.w,
                      margin: EdgeInsets.only(left: 6.0.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      //color: Colors.amber,
                      child: Text('${widget.b_desc}',
                        //overflow: TextOverflow.visible,
                        style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: 12.0.dp,
                            color: Colors.white
                        ),
                      ),),
                    SizedBox(
                      height: 2.0.h,
                      //child: ,
                    ),
                    Container(
                      height: 7.h,width: 70.w,
                      margin: EdgeInsets.only(left: 15.0.w),
                      //color: Color(0xffd41012),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Paymnt()));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd41012),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0)
                            )
                        ),
                        child: Text('Buy Plan',style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
