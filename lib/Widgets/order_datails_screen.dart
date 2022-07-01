import 'package:book_a_hall_admin_app/Models/hall_book_model.dart';
import 'package:book_a_hall_admin_app/providers/hall_book_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  final HallBookModel hallModel;

  const OrderDetailsScreen({Key? key, required this.hallModel})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String? orderStatus;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    HallBookProvider hallBookProvider=Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text('ORDER DETAILS'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.hallModel.userName!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Phone Number',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.hallModel.userPhoneNumber!,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hall Name',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.hallModel.hallName!,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Event Type',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.hallModel.eventType!,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Event Date',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.hallModel.eventDate!,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Date',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      widget.hallModel.orderDate!,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order ID',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        widget.hallModel.orderId!,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order Status',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    DropdownButton<String>(
                      focusColor: Colors.white,
                      value: widget.hallModel.orderStatus,
                      //elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: <String>[kProcessing, kCompleted, kCancelled]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          widget.hallModel.orderStatus = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: () async {
                    try {
                      setState(() {
                        loader=true;
                      });
                      await FirebaseFirestore.instance
                          .collection(kOrders)
                          .doc(widget.hallModel.orderId)
                          .update({
                        kOrderStatus: widget.hallModel.orderStatus,
                      });
                      if(hallBookProvider.currentIndex==0){
                        await hallBookProvider.getInProcessOrders();
                      }
                      if(hallBookProvider.currentIndex==1){
                        await hallBookProvider.getOrderHistory();
                      }
                      if(hallBookProvider.currentIndex==2){
                        await hallBookProvider.getCancelledOrder();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: greenColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 2),
                          content: const Text(
                            'UPDATED ORDER STATUS',
                            style: TextStyle(color: Colors.white),
                          )));
                      setState(() {
                        loader=false;
                      });
                    } on FirebaseException catch (e) {
                      setState(() {
                        loader=false;
                      });
                      if (kDebugMode) {
                        print(e);
                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: greenColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 2),
                          content: const Text(
                            'ERROR IN UPDATING ORDER STATUS!!',
                            style: TextStyle(color: Colors.white),
                          )));
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: loader == false
                          ? const Text(
                              'Update Order Status',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * .40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                CircleAvatar(
                                  radius: 40,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.network(
                                        widget.hallModel.userProfilePicture!,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Name',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        widget.hallModel.userName!,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Email',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        widget.hallModel.userEmail!,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Phone Number',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        widget.hallModel.userPhoneNumber!,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'User Id',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        widget.hallModel.userId!,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'View User Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
