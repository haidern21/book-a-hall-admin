
import 'package:book_a_hall_admin_app/providers/hall_book_provider.dart';
import 'package:flutter/material.dart';

import 'package:book_a_hall_admin_app/constants/constants.dart';
import 'package:provider/provider.dart';

import 'cancelled_order_screen.dart';
import 'in_process_order_screen.dart';
import 'order_history_screen.dart';

class ManageOrderScreen extends StatefulWidget {
  const ManageOrderScreen({Key? key}) : super(key: key);

  @override
  State<ManageOrderScreen> createState() => _ManageOrderScreenState();
}

class _ManageOrderScreenState extends State<ManageOrderScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    controller!.addListener(_getActiveTabIndex);
    super.initState();
  }
  int currentIndex=0;
  HallBookProvider? hallBookProvider;
  void _getActiveTabIndex() {
    setState(() {
      currentIndex = controller!.index;
    });
    hallBookProvider!.setIndex(currentIndex);
    debugPrint('CURRENT_PAGE $currentIndex');
  }
  @override
  Widget build(BuildContext context) {
    hallBookProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ORDERS'),
        bottom: TabBar(
          indicator: const BoxDecoration(
              border: Border(bottom: BorderSide(color: purpleColor, width: 3))),
          controller: controller,
          onTap: (index) {
          print(index.toString());
          },
          tabs: const [
            Tab(
              text: 'In Process',
            ),
            Tab(
              text: 'Order History',
            ),
            Tab(
              text: 'Cancelled',
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  greenGradientColor5,
                  greenGradientColor1,
                  greenGradientColor4,
                  greenGradientColor6,
                  greenGradientColor7,
                ]),
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          InProcessOrderScreen(),
          OrderHistoryScreen(),
          CancelledOrderScreen(),
        ],
      ),
    );
  }
}
