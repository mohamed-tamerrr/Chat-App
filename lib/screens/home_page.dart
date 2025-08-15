import 'package:chat/constants.dart';
import 'package:chat/models/message.dart';
import 'package:chat/widgets/chat_bubble.dart';
import 'package:chat/widgets/send_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller =
      TextEditingController();
  final ScrollController _scrollController =
      ScrollController();
  final CollectionReference db = FirebaseFirestore.instance
      .collection('message');

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(child: Text("Loading"));
        }

        List<Message> msgList = snapshot.data!.docs
            .map((doc) => Message.fromJson(doc))
            .toList();

        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollToBottom(),
        );

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/scholar.png',
                  height: 60,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Chat',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: kPrimaryColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: msgList.length,
                  itemBuilder: (context, i) {
                    return msgList[i].id == email
                        ? ChatBubble(msg: msgList[i])
                        : OtherChatBubble(msg: msgList[i]);
                  },
                ),
              ),
              SafeArea(
                child: SendTextField(
                  controller: _controller,
                  onSubmitted: (data) {
                    db.add({
                      'message': data,
                      'createdAt':
                          FieldValue.serverTimestamp(),
                      'id': email,
                    });
                    _controller.clear();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
