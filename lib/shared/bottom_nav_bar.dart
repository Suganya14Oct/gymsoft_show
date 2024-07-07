import 'package:flutter/material.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class BottomNavBar extends StatelessWidget {

  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){
      return Align(
        alignment: Alignment.bottomCenter,
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent
          ),
          child: Container(
            height: height * 0.011.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white54,Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (){
                    mainScreenNotifier.pageIndex = 0;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(Icons.home,size: 28.dp,color: mainScreenNotifier.pageIndex == 0 ?  Colors.red : Colors.white,),
                      ),
                      Text("Home",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 12.dp),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    mainScreenNotifier.pageIndex = 1;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset('assets/diet_small.png',height: 3.5.h,width: 7.3.w,fit: BoxFit.contain,color: mainScreenNotifier.pageIndex == 1 ? Color(0xffd41012) : Colors.white,)
                      ),
                      SizedBox(height: 0.7.w,),
                      Text("Diet",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 12.dp),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    mainScreenNotifier.pageIndex = 2;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(Icons.settings,size: 28.dp,color: mainScreenNotifier.pageIndex == 2 ?  Colors.red : Colors.white,),
                      ),
                      Text("Settings",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 12.dp),)
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    mainScreenNotifier.pageIndex = 3;
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(Icons.person,size: 28.dp,color: mainScreenNotifier.pageIndex == 3 ?  Colors.red : Colors.white,),
                      ),
                      Text("Profile",
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 12.dp),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}




