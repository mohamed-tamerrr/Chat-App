import 'package:chat/constants.dart';
import 'package:chat/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat/models/message.dart';
import 'package:chat/widgets/chat_bubble.dart';
import 'package:chat/widgets/send_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  final TextEditingController _controller =
      TextEditingController();
  final ScrollController _scrollController =
      ScrollController();

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
    void _scrollToBottom() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    var email = ModalRoute.of(context)!.settings.arguments;

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
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              var msgList = BlocProvider.of<ChatCubit>(
                context,
              ).msgList;
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scrollToBottom(),
              );
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: msgList.length,
                  itemBuilder: (context, i) {
                    return msgList[i].id == email
                        ? ChatBubble(msg: msgList[i])
                        : OtherChatBubble(msg: msgList[i]);
                  },
                ),
              );
            },
          ),
          SafeArea(
            child: SendTextField(
              controller: _controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMsg(
                  email: email.toString(),
                  message: data,
                );
                _controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
