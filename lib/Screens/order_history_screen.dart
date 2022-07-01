import 'package:book_a_hall_admin_app/Widgets/order_datails_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/order_item.dart';
import '../providers/hall_book_provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // HallBookProvider? hallBookProvider;
  Future? future;

  @override
  void initState() {
    Provider.of<HallBookProvider>(context, listen: false).getOrderHistory();
    future =
        Provider.of<HallBookProvider>(context, listen: false).getOrderHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HallBookProvider hallBookProvider = Provider.of(context, listen: false);
    // hallBookProvider.getOrderHistory();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:
          hallBookProvider.orderHistory.isNotEmpty
              ?
          FutureBuilder(
        future: future,
        builder: (context, snap) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(
                                  hallModel:
                                      hallBookProvider.orderHistory[index])));
                    },
                    child: OrderItem(
                        orderDate:
                            hallBookProvider.orderHistory[index].orderDate ??
                                '',
                        orderStatus:
                            hallBookProvider.orderHistory[index].orderStatus ??
                                'processing',
                        hallName:
                            hallBookProvider.orderHistory[index].hallName ??
                                'hall-name'),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: hallBookProvider.orderHistory.length);
        },
      )
      : Center(child: Image.asset('assets/images/no-order.png')),
    );
  }
}
