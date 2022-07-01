import 'package:book_a_hall_admin_app/Models/chat_model.dart';
import 'package:book_a_hall_admin_app/providers/chat_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../Widgets/chat_bubble_widget.dart';
import '../constants/constants.dart';

class ConversationScreen extends StatefulWidget {
  final String receiverId;

  const ConversationScreen({Key? key, required this.receiverId})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageController = TextEditingController();
  ChatModel chatModel = ChatModel();
  Future? future;
  Future? future1;

  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false)
        .getChatWithUser(widget.receiverId);
    future = Provider.of<ChatProvider>(context, listen: false)
        .getChatWithUser(widget.receiverId);
    Provider.of<ChatProvider>(context, listen: false)
        .getUserInfo(widget.receiverId);
    future1 = Provider.of<ChatProvider>(context, listen: false)
        .getUserInfo(widget.receiverId);
    super.initState();
  }

  bool loader = false;

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
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
          title: FutureBuilder(
            builder: (context, snap) {
              return Text(chatProvider.user.userName ?? '');
            },
          ),
          actions: [
            chatProvider.user.profilePicture == null ||
                    chatProvider.user.profilePicture!.isEmpty
                ? InkWell(
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
                                      backgroundColor: purpleColor,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: chatProvider
                                                      .user.profilePicture ==
                                                  null
                                              ? const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 50,
                                                )
                                              : Image.network(
                                                  chatProvider
                                                      .user.profilePicture!,
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
                                            chatProvider.user.userName ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                                            chatProvider.user.email ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                                            chatProvider.user.phoneNumber ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                                            chatProvider.user.userId ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                : InkWell(
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
                                      backgroundColor: purpleColor,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: chatProvider
                                                      .user
                                                      .profilePicture!
                                                      .isEmpty ||
                                                  chatProvider.user
                                                          .profilePicture ==
                                                      null
                                              ? const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 50,
                                                )
                                              : ClipRRect(
                                                  child: Image.network(
                                                    chatProvider
                                                        .user.profilePicture!,
                                                    fit: BoxFit.cover,
                                                  ),
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
                                            chatProvider.user.userName ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                                            chatProvider.user.email ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                                            chatProvider.user.phoneNumber ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                                            chatProvider.user.userId ?? '',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
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
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: CachedNetworkImage(
                            imageUrl: chatProvider.user.profilePicture!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        // body: Column(
        //   children: [
        //     Expanded(
        //       child: ListView.separated(
        //         itemBuilder: (context, index) {
        //           return InkWell(
        //             onLongPress: () async {
        //               await showDialog(
        //                   context: context,
        //                   builder: (context) {
        //                     return AlertDialog(
        //                       title: const Text('Are you sure want to delete message?'),
        //                       actions: [
        //                         TextButton(
        //                             child: const Text('cancel'),
        //                             onPressed: () => Navigator.of(context).pop()),
        //                         TextButton(
        //                           child: const Text('Yes'),
        //                           onPressed: () async {
        //                             await FirebaseFirestore.instance
        //                                 .collection(kChats)
        //                                 .doc(chatProvider
        //                                 .allMessages[index].messageId)
        //                                 .delete();
        //                             Navigator.of(context, rootNavigator: true)
        //                                 .pop();
        //                           },
        //                         ),
        //                       ],
        //                     );
        //                   });
        //             },
        //             child: ChatBubbleWidget(
        //               text: chatProvider.allMessages[index].message!,
        //               dateTime: chatProvider.allMessages[index].time.toString(),
        //               isYourMessage:
        //               chatProvider.allMessages[index].sentBy == '123456789'
        //                   ? true
        //                   : false,
        //             ),
        //           );
        //         },
        //         separatorBuilder: (context, index) => const SizedBox(
        //           height: 5,
        //         ),
        //         itemCount: chatProvider.allMessages.length,
        //       ),
        //     ),
        //     Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Padding(
        //         padding:
        //         const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        //         child: TextFormField(
        //           controller: messageController,
        //           decoration: InputDecoration(
        //               hintText: 'Enter Message',
        //               enabledBorder: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(10),
        //                   borderSide: const BorderSide(
        //                     color: greenColor,
        //                     width: 1,
        //                   )),
        //               focusedBorder: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(10),
        //                   borderSide: const BorderSide(
        //                     color: greenColor,
        //                     width: 1,
        //                   )),
        //               errorBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(10),
        //                 borderSide: const BorderSide(
        //                   color: greenColor,
        //                   width: 1,
        //                 ),
        //               ),
        //               focusedErrorBorder: OutlineInputBorder(
        //                 borderRadius: BorderRadius.circular(10),
        //                 borderSide: const BorderSide(
        //                   color: greenColor,
        //                   width: 1,
        //                 ),
        //               ),
        //               contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        //               suffixIcon: InkWell(
        //                   onTap: () async {
        //                     var messageId = const Uuid().v1();
        //                     if (messageController.text.isNotEmpty) {
        //                       chatModel.time = DateTime.now();
        //                       chatModel.sentBy = '123456789';
        //                       chatModel.messageId = messageId;
        //                       chatModel.seen = false;
        //                       chatModel.sentTo = widget.receiverId;
        //                       chatModel.message = messageController.text.trim();
        //                       await FirebaseFirestore.instance
        //                           .collection(kChats)
        //                           .doc(messageId)
        //                           .set(chatModel.asMap());
        //                       // await FirebaseFirestore.instance
        //                       //     .collection(kUsers)
        //                       //     .doc(widget.receiverId)
        //                       //     .collection('contacts')
        //                       //     .doc(widget.receiverId)
        //                       //     .update({});
        //                       messageController.clear();
        //                     }
        //                   },
        //                   child: const Icon(
        //                     Icons.send,
        //                     color: Colors.blue,
        //                   ))),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(builder: (context, snap) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () async {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'Are you sure want to delete message?'),
                                actions: [
                                  TextButton(
                                      child: const Text('cancel'),
                                      onPressed: () =>
                                          Navigator.of(context).pop()),
                                  TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection(kChats)
                                          .doc(chatProvider
                                              .allMessages[index].messageId)
                                          .delete();
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: ChatBubbleWidget(
                        text: chatProvider.allMessages[index].message!,
                        dateTime:
                            chatProvider.allMessages[index].time.toString(),
                        isYourMessage: chatProvider.allMessages[index].sentBy ==
                                '123456789'
                            ? true
                            : false,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: chatProvider.allMessages.length,
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                child: TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                      hintText: 'Enter Message',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greenColor,
                            width: 1,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: greenColor,
                            width: 1,
                          )),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: greenColor,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: greenColor,
                          width: 1,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      suffixIcon: InkWell(
                          onTap: () async {
                            var messageId = const Uuid().v1();
                            if (messageController.text.isNotEmpty) {
                              try {
                                setState(() {
                                  loader = false;
                                });
                                chatModel.time = DateTime.now();
                                chatModel.sentBy = '123456789';
                                chatModel.messageId = messageId;
                                chatModel.seen = false;
                                chatModel.sentTo = widget.receiverId;
                                chatModel.message =
                                    messageController.text.trim();
                                await FirebaseFirestore.instance
                                    .collection(kChats)
                                    .doc(messageId)
                                    .set(chatModel.asMap())
                                    .then((value) => print('message sent'));
                                await chatProvider
                                    .getChatWithUser(widget.receiverId);
                                messageController.clear();
                                setState(() {
                                  loader = false;
                                });
                              } on FirebaseException catch (e) {
                                setState(() {
                                  loader = false;
                                });
                              }
                            }
                          },
                          child: loader == false
                              ? const Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                )
                              : const CircularProgressIndicator(
                                  color: Colors.white,
                                ))),
                ),
              ),
            ),
          ],
        ));
  }
}
