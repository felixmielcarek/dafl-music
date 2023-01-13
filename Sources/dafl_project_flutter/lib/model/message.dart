import 'user.dart';

class Message {
  String idSender;
  String idReceiver;
  String content;


  Message({required this.idSender,
    required this.idReceiver,
    required this.content
  });


  Map<String, dynamic> toHashMap() {
    return {
      'idSender': idSender,
      'idReceiver': idReceiver,
      'content': content,
    };
  }


  factory Message.fromMap(Map<String, dynamic> data){
    return Message(
      idSender: data['idSender'],
      idReceiver: data['idReceiver'],
      content: data['content'],
    );
  }
}