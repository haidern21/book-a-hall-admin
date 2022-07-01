import 'package:book_a_hall_admin_app/constants/constants.dart';

class ChatModel {
  String? message;
  DateTime? time;
  String? sentTo;
  String? sentBy;
  String? messageId;
  bool? seen;

  ChatModel({
    this.sentBy,
    this.message,
    this.sentTo,
    this.time,
    this.messageId,
    this.seen,
  });

  Map<String, dynamic> asMap() {
    return {
      kMessage: message??'',
      kSentBy: sentBy??'',
      kSentTo: sentTo??'',
      kDateTime: time??'',
      kMessageId:messageId??'',
      kSeen:seen??false,
    };
  }
}
