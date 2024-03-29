import 'package:book_a_hall_admin_app/constants/constants.dart';

import '../constants/constants.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? userId;
  String? profilePicture;
  String? phoneNumber;
  List<dynamic>? favouriteHalls;
  int? unReadMessages;

  UserModel(
      {this.userName,
      this.email,
      this.unReadMessages,
      this.firstName,
      this.phoneNumber,
      this.lastName,
      this.userId,
      this.favouriteHalls,
      this.profilePicture});

  Map<String, dynamic> asMap() {
    return {
      kUserName: userName??'',
      kFirstName: firstName??'',
      kLastName: lastName??'',
      kUserEmail: email??'',
      kUserPhoneNumber: phoneNumber??'',
      kUserId: userId??'',
      kProfilePicture: profilePicture??'',
      kFavouriteHalls: favouriteHalls ?? [],
      kUnReadMessages:unReadMessages??0
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map[kUserName],
      firstName: map[kFirstName],
      lastName: map[kLastName],
      profilePicture: map[kProfilePicture],
      email: map[kUserEmail],
      userId: map[kUserId],
      phoneNumber: map[kUserPhoneNumber],
      favouriteHalls: map[kFavouriteHalls],
      unReadMessages: map[kUnReadMessages],
    );
  }
}
