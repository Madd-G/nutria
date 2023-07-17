import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../models/models.dart';
import '../../../responsive.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.modalContext});

  final BuildContext? modalContext;

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatModel> _messages = [];
  late FocusNode focusNode;
  final TextEditingController _textEditingController = TextEditingController();
  final userInstance = FirebaseFirestore.instance;
  User? loggedInUser = FirebaseAuth.instance.currentUser!;
  bool _isTyping = false;
  List<String> konteks = [];
  List<String> chatSession = [
    'Let\'s role-play, you only know about fruits and vegetables, other than greetings or unrelated questions about fruits or vegetables, you pretend not to know.'
        .tr
  ];

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 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",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> parsedResponse = json.decode(response.body);

    String reply = parsedResponse['choices'][0]['message']['content'];
    return reply;
  }

  final _auth = FirebaseAuth.instance;
  late String messageText;
  final messageTextController = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    focusNode = FocusNode();
    // ignore: unused_local_variable
    List<String> chatSession = [
      'Let\'s role-play, you only know about fruits and vegetables, other than greetings or unrelated questions about fruits or vegetables, you pretend not to know.'
          .tr
    ];
    // ignore: unused_local_variable
    List<String> konteks = [];
    super.initState();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      rethrow;
    }
  }

  void onSendMessage() async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "You can't send multiple messages at a time".tr,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please ask any questions about fruits or vegetables".tr,
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      _isTyping = true;
      ChatModel message =
          ChatModel(text: _textEditingController.text, isMe: true);
      _textEditingController.clear();

      setState(() {
        _messages.insert(0, message);
      });
      chatSession.add(messageText);
      // ignore: unused_local_variable
      String chats = chatSession.join(',');
      String finalmessage =
          '${'Let\'s role play, you become a fruit and vegetable expert, in addition to greetings and questions related to fruits and vegetables, answer "Sorry I don\'t understand, I only understand about fruits and vegetables". If the question is about fruits and vegetables, answer based on the context of the previous question as a reference.'.tr} ${(konteks.isNotEmpty) ? konteks.last : ''}, ${'questions to be answered'.tr}: $messageText';
      konteks.add(messageText);
      String response = await sendMessageToChatGpt(finalmessage);

      userInstance
          .collection('messages')
          .doc(loggedInUser!.uid)
          .collection('messageList')
          .add(
        {
          'text': response,
          'sender': 'NutriAI',
          // 'timestamp': FieldValue.serverTimestamp(),
          'timestamp': DateTime.now(),
        },
      );
      _isTyping = false;
      ChatModel chatGpt = ChatModel(text: response, isMe: false);

      setState(() {
        _messages.insert(0, chatGpt);
      });
      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(Responsive.isTablet(context) ? 45.0 : 25.0),
          child: Padding(
            padding: EdgeInsets.all(Responsive.isTablet(context) ? 14.0 : 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'NutriAI BOT',
                  style: TextStyle(
                      fontSize: Responsive.isTablet(context) ? 25 : 18.0,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 45.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MessageStream(),
          if (_isTyping) ...[
            SpinKitThreeBounce(
              // color: Colors.black,
              size: 18,
            ),
          ],
          Container(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 10.0, right: 10.0, bottom: 50.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.multiline,
                      showCursor: true,
                      // cursorColor: Colors.black,
                      minLines: 1,
                      maxLines: 10,
                      focusNode: focusNode,
                      style: const TextStyle(
                          // color: Colors.black,
                          fontSize: 14.0),
                      decoration: InputDecoration(
                        hintText: "ask about fruits or vegetables".tr,
                        hintStyle: TextStyle(
                            // color: Colors.grey,
                            fontSize:
                                Responsive.isTablet(context) ? 15.0 : 12.0),
                        contentPadding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        // fillColor: const Color(0xFFF6F6F6),
                      ),
                      onChanged: (value) {
                        messageText = value;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      userInstance
                          .collection('messages')
                          .doc(loggedInUser!.uid)
                          .collection('messageList')
                          .add(
                        {
                          'text': messageText,
                          'sender': loggedInUser?.email,
                          // 'timestamp': FieldValue.serverTimestamp(),
                          'timestamp': DateTime.now(),
                        },
                      );
                      onSendMessage();
                    },
                    icon: const Icon(
                      Icons.send,
                      // color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userInstance = FirebaseFirestore.instance;
    User? loggedInUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<QuerySnapshot>(
      stream: userInstance
          .collection('messages')
          .doc(loggedInUser.uid)
          .collection('messageList')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
                // backgroundColor: Theme.of(context).colorScheme.primary,
                ),
          );
        }
        final messages = snapshot.data?.docs;
        List<ChatContent> messageWidgets = [];

        for (var message in messages!) {
          final messageText = message['text'];
          final messageSender = message['sender'];
          final messageTime = message['timestamp'];

          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {}
          final messageBubbles = ChatContent(
            sender: messageSender,
            text: messageText,
            isMe: loggedInUser.email == messageSender,
            time: messageTime,
          );
          messageWidgets.add(messageBubbles);
        }
        return Expanded(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            reverse: true,
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class ChatContent extends StatelessWidget {
  final String text;
  final String sender;
  final Timestamp? time;
  final bool isMe;

  const ChatContent({
    super.key,
    required this.text,
    required this.sender,
    required this.isMe,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: isMe
                ? Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                    fontSize: Responsive.isTablet(context)
                                        ? 20.0
                                        : 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              '${(time!.toDate().hour > 12) ? time!.toDate().hour - 12 : time?.toDate().hour}: ${time?.toDate().minute} ${(time!.toDate().hour > 12) ? 'PM' : 'AM'}',
                              style: TextStyle(
                                  fontSize: Responsive.isTablet(context)
                                      ? 15.0
                                      : 10.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(6.0),
                                bottomLeft: Radius.circular(6.0),
                                bottomRight: Radius.circular(6.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                text,
                                style: TextStyle(
                                    fontSize: Responsive.isTablet(context)
                                        ? 20.0
                                        : 15.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              '${(time!.toDate().hour > 12) ? time!.toDate().hour - 12 : time?.toDate().hour}: ${time?.toDate().minute} ${(time!.toDate().hour > 12) ? 'PM' : 'AM'}',
                              style: TextStyle(
                                  fontSize: Responsive.isTablet(context)
                                      ? 15.0
                                      : 10.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
