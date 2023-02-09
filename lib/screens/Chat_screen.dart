
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User sender;

class Chat_screen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const Chat_screen({Key? key}) : super(key: key);

  @override
  _Chat_screenState createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  final messageTextConrroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // late User sender;
  String? message;

  bool showSpinner = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        sender = user;
        print(sender.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await FirebaseFirestore.instance.collection('Chat').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  void messagesStreams() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('Chat').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF455D83),
          title: Row(
            children: [
              Image.asset('assests/images/chat.png', height: 35),
              SizedBox(width: 10),
              Text('Chat')
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // messagesStreams();
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            )
          ],
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            messageStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 41, 92, 116),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextConrroller,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'Write your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(13.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          messageTextConrroller.clear();
                          FirebaseFirestore.instance.collection('Chat').add({
                            'sender': sender.email,
                            'message': message,
                            'time': FieldValue.serverTimestamp(),
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [Icon(Icons.send_outlined)],
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(13)),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 255, 255)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF455D83)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: const Color(0xFF455D83)))))),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}

class messageStream extends StatelessWidget {
  const messageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Chat')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        List<messageLine> messageWidgets = [];
        if (!snapshot.hasData) {
          return Center(
            child:  CircularProgressIndicator()
          );
        }
        final messages = snapshot.data!.docs;
        for (var message in messages) {
          final messageText = message.get('message');
          final messageSender = message.get('sender');
          final currentUser = sender.email;

          final messageWidget = messageLine(
            sender: messageSender,
            message: messageText,
            isMe: currentUser == messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class messageLine extends StatelessWidget {
  const messageLine({this.message, this.sender, required this.isMe, Key? key})
      : super(key: key);
  final String? sender;
  final String? message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? const Color(0xFF455D83) : Color.fromARGB(255, 179, 193, 215),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$message',
                style: TextStyle(
                    fontSize: 17, color: isMe ? Colors.white : Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

