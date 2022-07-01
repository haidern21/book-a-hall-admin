import 'package:book_a_hall_admin_app/Screens/HomePage.dart';
import 'package:book_a_hall_admin_app/Screens/add_hall_details_screen.dart';
import 'package:book_a_hall_admin_app/Screens/all-halls-screen.dart';
import 'package:book_a_hall_admin_app/Screens/all_chat_screen.dart';
import 'package:book_a_hall_admin_app/Screens/manage_order_screen.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var  pages = [
      const AllHallsScreen(),
      AllChatsScreen(),
      const AddHallDetailsScreen(),
      const ManageOrderScreen(),
    ];
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: purpleColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Halls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add HAll',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg),
            label: 'Orders',
          ),],
      ),
    );
  }
}
