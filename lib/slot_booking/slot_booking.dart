import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft_show/slot_booking/my_bookings.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SlotBooking extends StatefulWidget {
  const SlotBooking({super.key});

  @override
  State<SlotBooking> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> with SingleTickerProviderStateMixin {


  final ScrollController _scrollController = ScrollController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late TabController _tabController;

  final List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final List<String> forenoonSlots = [
    '6am - 7am',
    '7am - 8am',
    '8am - 9am',
    '9am - 10am',
    '10am - 11am',
  ];

  final List<String> afternoonSlots = [
    '11am - 12pm',
    '12pm - 1pm',
    '1pm - 2pm',
    '2pm - 3pm',
    '3pm - 4pm',
    '5pm - 6pm',
    '6pm - 7pm',
    '7pm - 8pm',
    '8pm - 9pm',
    '9pm - 10pm'
  ];

  late List<bool> isSelected;

  int selectedIndex = -1;

  final List<String> available_slots = [
    '11am - 12pm',
    '12pm - 1pm',
    '1pm - 2pm',
    '2pm - 3pm',
    '3pm - 4pm',
    '4pm - 5pm',
    '8pm - 9pm',
    '9pm - 10pm',
  ];

  final List<String> total_slots = [
    '6am - 7am',
    '7am - 8am',
    '8am - 9am',
    '9am - 10am',
    '10am - 11am',
    '11am - 12pm',
    '12pm - 1pm',
    '1pm - 2pm',
    '2pm - 3pm',
    '3pm - 4pm',
    '4pm - 5pm',
    '8pm - 9pm',
    '9pm - 10pm',
  ];

  final Map<String, String?> selectedSlots = {
    'Sunday': null,
    'Monday': null,
    'Tuesday': null,
    'Wednesday': null,
    'Thursday': null,
    'Friday': null,
    'Saturday': null,
  };


  String formattedDate = DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.now());

  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: weekdays.length, vsync: this);
    isSelected = List.generate(available_slots.length, (_) => false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _dateController.dispose();
    mounted;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            "assets/female_blur_bg.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                            // print('Navigating');
                            //mainScreenNotifier.pageIndex = 0;
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
                      Text("Slot Booking",
                        style: TextStyle(color: Colors.white,fontSize: 25.dp ))
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0),
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      tabs: weekdays.map((day) => Tab(
                        text: day,
                      )).toList(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: weekdays.map((day) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildSlotSection('ForeNoon Slots (AM)', forenoonSlots, day),
                              _buildSlotSection('AfterNoon Slots (PM)', afternoonSlots, day),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 7.h,
                        width: 35.w,
                        margin: EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                          ),
                          onPressed: (){
                           
                            Map<String, String> nonNullableSelectedSlots = selectedSlots.map((key, value) => MapEntry(key, value ?? ""));
                            
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyBookings(selectedSlots: nonNullableSelectedSlots)));
                           
                          },
                          child: Text('My Bookings',style: TextStyle(color: Colors.red,fontFamily: 'Telex')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 7.h,
                    width: 70.w,
                    child: ElevatedButton(
                      onPressed: (){
                        _showSelectedSlotsDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd41012),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.0)
                        )
                      ),
                      child: Text('Book My Slot', style: TextStyle(fontSize: 15.0.dp,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlotSection(String title, List<String> slots, String day) {

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 10),
          padding: EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 15),),
          ),
        ),
        Container(
          height: 180,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2,
              ),
              itemCount: slots.length,
              itemBuilder: (context, index) {

                String slot = slots[index];
                bool isSelected = selectedSlots[day] == slot;

                return GestureDetector(
                  onTap: (){
                    setState(() {
                      if (isSelected) {
                        selectedSlots[day] = null;
                      } else {
                        selectedSlots[day] = slot;
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.lightBlueAccent : Colors.white60,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(slots[index],style: TextStyle(color: Colors.black)),
                  )
                );
              }
          ),
        )
      ],
    );
  }

  void _showSelectedSlotsDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected SLots',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black87,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weekdays.map((day) {
              String selectedSlot = selectedSlots[day] ?? 'None';
              return Text(' $day: $selectedSlot',style: TextStyle(color: Colors.white));
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected Slots were Booked!!',
                          style: TextStyle(fontSize: 15.0,color: Colors.black)),
                      backgroundColor: Colors.grey.shade300)
                );
                Navigator.of(context).pop();
              },
              child: Text('Close',style: TextStyle(color: Colors.redAccent)),
            )
          ],
        );
      }
    );
  }

  void _showAlertDialog(BuildContext context, String selectedSlot, String selectedDate) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selected Slot'),
            content: Text("Date: $selectedDate\nSlot: $selectedSlot"),
            actions: <Widget>[
              TextButton(
                  child: Text("Close"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  })
            ],
          );
        }
    );
  }

  void _scrollToIndex(int index) {

    double scrollTo = (index * 400.0) + 200.0; // Adjust as needed
    _scrollController.animateTo(
      scrollTo,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    if(!isSelected[index]){
      setState(() {
        isSelected[index] = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {

    final now = DateTime.now();

    final currentWeekStart = now.subtract(Duration(days: now.weekday % 7));
    final currentWeekEnd = currentWeekStart.add(Duration(days: 6));

    
    final ThemeData themedata = ThemeData(
         dialogBackgroundColor: Colors.white,
        visualDensity: VisualDensity(
          horizontal: 2.0,
          vertical: 2.0
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.pinkAccent,
          onPrimary: Colors.white,
          surface: Colors.white, // Set white transparent color for the calendar
          onSurface: Colors.black,
        ),

      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentTextStyle: TextStyle(fontSize: 12.0),
      ),
    );
    
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: currentWeekEnd,
      builder: (context, child){
        return Theme(
          data: themedata,
          child:  SizedBox(
            height: MediaQuery.of(context).size.height * 0.4, // Customize the height as desired
            child:  Container(
              decoration: BoxDecoration(
                border: Border.all(
                 color: Colors.white),
              ),
              child: child,
            ),
          ),
        );
      }
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toString().substring(0, 10);
      });
    }
  }
}
