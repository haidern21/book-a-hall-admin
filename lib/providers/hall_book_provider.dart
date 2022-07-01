import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../Models/hall_book_model.dart';
import '../constants/constants.dart';

class HallBookProvider with ChangeNotifier {
  List<HallBookModel> inProcessOrder = [];
  List<HallBookModel> orderHistory=[];
  List<HallBookModel> cancelledOrder=[];
  int currentIndex=0;
  void setIndex(int index){
    currentIndex=index;
    print('current index from provider class:$currentIndex');
    notifyListeners();
  }


  getInProcessOrders() async {
    print('in process orders');
    List<HallBookModel> tempInProcessOrders = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection(kOrders).orderBy(kOrderDate,descending: false).get();
    for (var element in value.docs) {
      if (element.get(kOrderStatus)==kProcessing) {
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate)??'',
        );
        tempInProcessOrders.add(hallBookModel);
      }
    }
    inProcessOrder=tempInProcessOrders;
    notifyListeners();
  }

  getOrderHistory()async{
    print('get order history');
    List<HallBookModel> tempOrderHistory=[];
    QuerySnapshot value= await FirebaseFirestore.instance.collection(kOrders).orderBy(kOrderDate,descending: false).get();
    for (var element in value.docs) {
      if(element.get(kOrderStatus)==kCompleted){
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate)??'',
        );
        tempOrderHistory.add(hallBookModel);
      }
    }
    orderHistory=tempOrderHistory;
    notifyListeners();
  }
  getCancelledOrder()async{
    print('get cancelled orders');
    List<HallBookModel> tempCancelledOrder=[];
    QuerySnapshot value= await FirebaseFirestore.instance.collection(kOrders).orderBy(kOrderDate,descending: true).get();
    for (var element in value.docs) {
      if(element.get(kOrderStatus)==kCancelled){
        HallBookModel hallBookModel = HallBookModel(
          userId: element.get(kUserId) ?? '',
          hallName: element.get(kHallName) ?? '',
          userName: element.get(kUserName) ?? '',
          eventDate: element.get(kEventDate) ?? '',
          eventType: element.get(kEventType) ?? '',
          userEmail: element.get(kUserEmail) ?? '',
          userPhoneNumber: element.get(kUserPhoneNumber) ?? '',
          userProfilePicture: element.get(kProfilePicture) ?? '',
          orderId: element.get(kOrderId) ?? '',
          orderStatus: element.get(kOrderStatus) ?? '',
          orderDate: element.get(kOrderDate)??'',
        );
        tempCancelledOrder.add(hallBookModel);
      }
    }
    cancelledOrder=tempCancelledOrder;
    notifyListeners();
  }
}
