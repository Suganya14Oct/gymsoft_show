import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:gymsoft_show/home_page/diet.dart';
import 'package:gymsoft_show/home_page/home_page.dart';
import 'package:gymsoft_show/profile/profile.dart';
import 'package:gymsoft_show/settings/settings.dart';
import 'package:gymsoft_show/shared/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {

  final token;

  MainScreen({@required this.token,super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget>? pageList;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('phone');
      print('Data from splash Screen : ${widget.token}');
      // Initialize pageList here after widget is fully initialized
      pageList = [
        HomePage(token: widget.token),
        Diet(),
        Settings(),
        Profile()
      ];

    });
  }


  String? accessToken;

  @override
  void initState() {
    _loadToken();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child){
        return WillPopScope(
          onWillPop: () async {
            // final SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
            // sharedPrefereces.setString("phone", widget.token);
            //
            // if( widget.token != null){
            //   setState(() {
            //     _back(context);
            //   });
            // }else{
            //   setState(() {
            //     SystemNavigator.pop();
            //   });
            // }
            // return false;

            bool exitConfirmed = await _showExitConfirmationDialog(context);
            return exitConfirmed;
          },
          child: Scaffold(
            body: Stack(
              children: [
                if (pageList != null) pageList![mainScreenNotifier.pageIndex] ?? Container(),
                //pageList![mainScreenNotifier.pageIndex],
                BottomNavBar()
              ],
            ),
          ),
        );
      },
    );
  }
  _back(context) {

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("Do you want to Exit??"),
            actions: [
              TextButton(
                  onPressed: () async {
                    final SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
                    sharedPrefereces.setString("phone", widget.token);
                    SystemNavigator.pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
            ],
          );
        });
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {

    bool exitConfirmed = false;

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Do you want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () async {
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString("phone", widget.token ?? '');
                  SystemNavigator.pop();
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              )
            ],
          );
        },
    ).then((value) {
      exitConfirmed = value ?? false;
    });

    return exitConfirmed;
  }

}
