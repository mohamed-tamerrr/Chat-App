class Message {
  String msg;
  String id;
  Message(this.msg, this.id);

  factory Message.fromJson(json) {
    return Message(json['message'], json['id']);
  }
}
