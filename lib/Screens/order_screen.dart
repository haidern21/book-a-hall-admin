// import 'package:book_a_hall_admin_app/Widgets/order_datails_screen.dart';
// import 'package:book_a_hall_admin_app/Widgets/order_item.dart';
// import 'package:book_a_hall_admin_app/providers/hall_book_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../constants/constants.dart';
//
// class OrderScreen extends StatefulWidget {
//   const OrderScreen({Key? key}) : super(key: key);
//
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     HallBookProvider hallBookProvider = Provider.of(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Orders'),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     greenGradientColor5,
//                     greenGradientColor1,
//                     greenGradientColor4,
//                     greenGradientColor6,
//                     greenGradientColor7,
//                   ]),
//             ),
//           ),
//         ),
//         body: FutureBuilder(
//           future: hallBookProvider.getAllOrdersForAdmin(),
//           builder: (context, snapshot) {
//             if (hallBookProvider.allOrders.isEmpty) {
//               return const Center(
//                 child: Text('NO DATA'),
//               );
//             }
//             return Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
//               child: ListView.separated(
//                   itemBuilder: (context, index) => InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => OrderDetailsScreen(
//                                       hallModel:
//                                           hallBookProvider.allOrders[index])));
//                         },
//                         child: OrderItem(
//                             orderDate:
//                                 hallBookProvider.allOrders[index].orderDate!,
//                             orderStatus:
//                                 hallBookProvider.allOrders[index].orderStatus!,
//                             hallName:
//                                 hallBookProvider.allOrders[index].hallName!),
//                       ),
//                   separatorBuilder: (context, index) => const SizedBox(
//                         height: 10,
//                       ),
//                   itemCount: hallBookProvider.allOrders.length),
//             );
//           },
//         ));
//   }
// }
