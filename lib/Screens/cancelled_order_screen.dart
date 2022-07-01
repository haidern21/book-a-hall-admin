import 'package:book_a_hall_admin_app/Widgets/order_datails_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/order_item.dart';
import '../providers/hall_book_provider.dart';

class CancelledOrderScreen extends StatefulWidget {
  const CancelledOrderScreen({Key? key}) : super(key: key);

  @override
  _CancelledOrderScreenState createState() => _CancelledOrderScreenState();
}

class _CancelledOrderScreenState extends State<CancelledOrderScreen> {
  // HallBookProvider? hallBookProvider;
  Future? future;

  @override
  void initState() {
    Provider.of<HallBookProvider>(context, listen: false).getCancelledOrder();
    future = Provider.of<HallBookProvider>(context, listen: false)
        .getCancelledOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HallBookProvider hallBookProvider = Provider.of(context);
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body:
            hallBookProvider.cancelledOrder.isNotEmpty
                ?
            FutureBuilder(
          future: future,
          builder: (context, snap) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                    hallModel: hallBookProvider
                                        .cancelledOrder[index])));
                      },
                      child: OrderItem(
                          // orderId:
                          //     hallBookProvider.inProcessOrder[index].orderId ?? '',
                          orderDate: hallBookProvider
                                  .cancelledOrder[index].orderDate ??
                              '',
                          orderStatus: hallBookProvider
                                  .cancelledOrder[index].orderStatus ??
                              'processing',
                          hallName:
                              hallBookProvider.cancelledOrder[index].hallName ??
                                  'hall-name'),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                itemCount: hallBookProvider.cancelledOrder.length);
          },
        )
        : Center(
            child: Image.asset('assets/images/no-order.png'),
          ),
        );
  }
}
