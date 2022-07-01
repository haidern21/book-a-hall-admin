import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../Models/chat_model.dart';
import '../Models/user_model.dart';
import '../constants/constants.dart';

class ChatProvider extends ChangeNotifier {
  List<ChatModel> allMessages = [];
  List<UserModel> allChatUsers = [];
  List<ChatModel> unreadUserMessages = [];
  UserModel user = UserModel();

  getUserInfo(String userId) async {
    List<UserModel> allUser = [];
    print('getuserinfo');
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot userValue =
          await FirebaseFirestore.instance.collection(kUsers).doc(userId).get();
      user.firstName = userValue.get(kFirstName) ?? '';
      user.lastName = userValue.get(kLastName) ?? '';
      user.email = userValue.get(kUserEmail) ?? '';
      user.profilePicture = userValue.get(kProfilePicture) ?? '';
      user.userName = userValue.get(kUserName) ?? '';
      user.favouriteHalls = userValue.get(kFavouriteHalls) ?? [];
      user.phoneNumber = userValue.get(kUserPhoneNumber) ?? '';
      user.userId = userValue.get(kUserId) ?? '';
      allUser.add(user);
      user = allUser.first;
      notifyListeners();
    }
  }

  getAllChatUsers() async {
    print('get all chat users');
    List<UserModel> tempAllChatUsers = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kAdmin)
        .doc('a9WBHXTOwETcS3Qwlx7M')
        .collection('contacts')
        .orderBy('last-message', descending: false)
        .get();
    for (var element in value.docs) {
      DocumentSnapshot userValue = await FirebaseFirestore.instance
          .collection(kUsers)
          .doc(element.get('user-id'))
          .get();
      UserModel userModel = UserModel(
        firstName: userValue.get(kFirstName) ?? '',
        lastName: userValue.get(kLastName) ?? '',
        email: userValue.get(kUserEmail) ?? '',
        profilePicture: userValue.get(kProfilePicture) ?? '',
        userName: userValue.get(kUserName) ?? '',
        favouriteHalls: userValue.get(kFavouriteHalls) ?? [],
        phoneNumber: userValue.get(kUserPhoneNumber) ?? '',
        userId: userValue.get(kUserId) ?? '',
        unReadMessages: userValue.get(kUnReadMessages) ?? 0,
      );
      tempAllChatUsers.add(userModel);
    }
    allChatUsers = tempAllChatUsers;
    notifyListeners();
  }

  getChatWithUser(String receiverId) async {
    print('getchatwithuser');
    List<ChatModel> tempChat = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(kChats)
        .orderBy(kDateTime, descending: false)
        .get();
    for (var element in value.docs) {
      if (element.get(kSentTo) == '123456789' &&
          element.get(kSentBy) == receiverId) {
        ChatModel chatModel = ChatModel(
          message: element.get(kMessage),
          sentTo: element.get(kSentTo),
          sentBy: element.get(kSentBy),
          time: (element.get(kDateTime) as Timestamp).toDate(),
          seen: element.get(kSeen),
          messageId: element.get(kMessageId),
        );
        tempChat.add(chatModel);
      }
      if (element.get(kSentTo) == receiverId &&
          element.get(kSentBy) == '123456789') {
        ChatModel chatModel = ChatModel(
          message: element.get(kMessage),
          sentTo: element.get(kSentTo),
          sentBy: element.get(kSentBy),
          time: (element.get(kDateTime) as Timestamp).toDate(),
          seen: element.get(kSeen),
          messageId: element.get(kMessageId),
        );
        tempChat.add(chatModel);
      }
      allMessages = tempChat;
      notifyListeners();
    }
  }

   clearUnreadMessageCount(String userId)async{
    print('message count clear');
   await FirebaseFirestore.instance.collection(kUsers).doc(userId).update({
      kUnReadMessages:0,
    });
   }
}
