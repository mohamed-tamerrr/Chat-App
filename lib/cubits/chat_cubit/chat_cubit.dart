import 'package:bloc/bloc.dart';
import 'package:chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final CollectionReference db = FirebaseFirestore.instance
      .collection('message');
  List<Message> msgList = [];
  void sendMsg({
    required String email,
    required String message,
  }) {
    db.add({
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
      'id': email,
    });
  }

  void getMsg() {
    db
        .orderBy('createdAt', descending: false)
        .snapshots()
        .listen((event) {
          msgList.clear();
          for (var d in event.docs) {
            msgList.add(Message.fromJson(d));
          }
          emit(ChatSuccess(msgList));
        });
  }
}
