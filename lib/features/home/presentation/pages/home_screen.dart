import 'package:amirtha_ayurvedha/common/theme/app_palatte.dart';
import 'package:amirtha_ayurvedha/common/widgets/common_button.dart';
import 'package:flutter/material.dart';

import '../../data/model/my_booking_model.dart';
import '../widgets/my_bookings_widget.dart';
import '../widgets/search_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MyBookingModel> myBookingsList = [
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/notification_icon.png'))
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton(
          backgroundColor: AppPalette.appColor, onPressed: () {  },
          child: CommonButton(buttonText: 'Register Now', onPressed: (){
            Navigator.pushNamed(context, '/RegisterScreen');
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                const Flexible(
                    flex: 6,
                    child: SizedBox(height: 55, child: SearchTexField())),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    flex: 3,
                    child: CommonButton(buttonText: 'Search', onPressed: () {}))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sort by:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      //shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.85,
                        color: AppPalette.borderColor,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0, right: 100),
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppPalette.appColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              itemCount: myBookingsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: MyBookingWidget(
                    myBookingModel: myBookingsList[index],
                    count: index + 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
