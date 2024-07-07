import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:gymsoft_show/controller/mainscreen_provider.dart';
import 'package:gymsoft_show/feedback/feedback.dart';
import 'package:gymsoft_show/home_page/diet.dart';
import 'package:gymsoft_show/home_page/home_page.dart';
import 'package:gymsoft_show/home_page/main_screen.dart';
import 'package:gymsoft_show/login/forgot_password.dart';
import 'package:gymsoft_show/login/login.dart';
import 'package:gymsoft_show/login/otp_page.dart';
import 'package:gymsoft_show/login/reset_password.dart';
import 'package:gymsoft_show/login/splash_screen.dart';
import 'package:gymsoft_show/notification/local_noti.dart';
import 'package:gymsoft_show/notification/notificat.dart';
import 'package:gymsoft_show/notification/notify_me.dart';
import 'package:gymsoft_show/payment/payment.dart';
import 'package:gymsoft_show/plan/buy_plan.dart';
import 'package:gymsoft_show/plan/plan.dart';
import 'package:gymsoft_show/profile/edit_profile.dart';
import 'package:gymsoft_show/profile/profile.dart';
import 'package:gymsoft_show/settings/change_password.dart';
import 'package:gymsoft_show/settings/settings.dart';
import 'package:gymsoft_show/slot_booking/my_bookings.dart';
import 'package:gymsoft_show/slot_booking/slot_booking.dart';
import 'package:gymsoft_show/trainer/trainer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await LocalNoti.init();

  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => MainScreenNotifier()),
        ChangeNotifierProvider(create: (_) => ProfileNotifier())
    ],
      child: const MyApp(),
    )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return FlutterSizer(
      builder: (context, orientation, screenType){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'GymSoft',
          theme: ThemeData(
            fontFamily: 'Telex',
            primaryColor: Colors.white70,
            buttonTheme: ButtonThemeData(
              buttonColor: Color(0xff831E1E),
            ),
          ),
         //home: SplashScreen(),
          home: SplashScreen(),
        );
      },
    );
  }
}
