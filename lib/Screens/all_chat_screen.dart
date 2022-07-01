import 'package:book_a_hall_admin_app/providers/chat_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import 'conversation_screen.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  // ChatProvider? chatProvider;
  Future? future;

  @override
  void initState() {
    Provider.of<ChatProvider>(context, listen: false).getAllChatUsers();
    future =
        Provider.of<ChatProvider>(context, listen: false).getAllChatUsers();
    // Provider.of<ChatProvider>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('MESSAGES'),
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
        body: chatProvider.allChatUsers.isNotEmpty?FutureBuilder(
          builder: (context, snap) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () async {
                         chatProvider.clearUnreadMessageCount(
                            chatProvider.allChatUsers[index].userId.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConversationScreen(
                                      receiverId: chatProvider
                                          .allChatUsers[index].userId
                                          .toString(),
                                    )));
                         chatProvider.getAllChatUsers();
                      },
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),
                                    child: chatProvider.allChatUsers[index]
                                            .profilePicture!.isEmpty
                                        ? const Center(
                                            child: Icon(
                                            Icons.person,
                                            size: 40,
                                          ))
                                        : CachedNetworkImage(
                                            imageUrl: chatProvider
                                                .allChatUsers[index]
                                                .profilePicture!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    chatProvider.allChatUsers[index].userName ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            chatProvider.allChatUsers[index].unReadMessages != 0
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color: purpleColor,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        chatProvider
                                            .allChatUsers[index].unReadMessages
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 14,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                itemCount: chatProvider.allChatUsers.length);
          },
        )
        : Center(
            child: Image.asset("assets/images/no-order.png"),
          ),
        );
  }
}
