// import 'package:book_a_hall_admin_app/Screens/add_hall_details_screen.dart';
// import 'package:book_a_hall_admin_app/Screens/all-halls-screen.dart';
// import 'package:book_a_hall_admin_app/Screens/all_chat_screen.dart';
// import 'package:book_a_hall_admin_app/Screens/manage_order_screen.dart';
// import 'package:book_a_hall_admin_app/Screens/order_screen.dart';
// import 'package:flutter/material.dart';
//
// import '../constants/constants.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HOMEPAGE'),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   greenGradientColor5,
//                   greenGradientColor1,
//                   greenGradientColor4,
//                   greenGradientColor6,
//                   greenGradientColor7,
//                 ]),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const AddHallDetailsScreen()));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20)),
//                     height: MediaQuery.of(context).size.height * .15,
//                     width: MediaQuery.of(context).size.width * .45,
//                     child: const Center(
//                       child: Text(
//                         'Add Hall Details',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> AllChatsScreen()));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20)),
//                     height: MediaQuery.of(context).size.height * .15,
//                     width: MediaQuery.of(context).size.width * .45,
//                     child: const Center(
//                       child: Text(
//                         'Messages',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                             const ManageOrderScreen()));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20)),
//                     height: MediaQuery.of(context).size.height * .15,
//                     width: MediaQuery.of(context).size.width * .45,
//                     child: const Center(
//                       child: Text(
//                         'Orders',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const AllHallsScreen()));
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20)),
//                     height: MediaQuery.of(context).size.height * .15,
//                     width: MediaQuery.of(context).size.width * .45,
//                     child: const Center(
//                       child: Text(
//                         'Halls',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
