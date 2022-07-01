import 'package:book_a_hall_admin_app/Widgets/order_datails_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/order_item.dart';
import '../providers/hall_book_provider.dart';

class InProcessOrderScreen extends StatefulWidget {
  const InProcessOrderScreen({Key? key}) : super(key: key);

  @override
  _InProcessOrderScreeState createState() => _InProcessOrderScreeState();
}

class _InProcessOrderScreeState extends State<InProcessOrderScreen> {
  // HallBookProvider? hallBookProvider;
  Future? future;

  @override
  void initState() {
    Provider.of<HallBookProvider>(context, listen: false).getInProcessOrders();
    future = Provider.of<HallBookProvider>(context, listen: false)
        .getInProcessOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HallBookProvider hallBookProvider = Provider.of(context);
    // hallBookProvider.getInProcessOrders();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:
          hallBookProvider.inProcessOrder.isNotEmpty
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
                                      hallBookProvider.inProcessOrder[index])));
                    },
                    child: OrderItem(
                      orderDate:
                          hallBookProvider.inProcessOrder[index].orderDate ??
                              '',
                      orderStatus:
                          hallBookProvider.inProcessOrder[index].orderStatus ??
                              'processing',
                      hallName:
                          hallBookProvider.inProcessOrder[index].hallName ??
                              'hall-name',
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: hallBookProvider.inProcessOrder.length);
        },
      )
      : Center(
          child: Image.asset('assets/images/no-order.png'),
        ),
    );
  }
}
