import 'user.dart';

class Message {
  String idSender;
  String idReceiver;
  String content;
  String timestamp;


  Message({required this.idSender,
    required this.idReceiver,
    required this.content,
    required this.timestamp
  });


  Map<String, dynamic> toHashMap() {
    return {
      'idSender': idSender,
      'idReceiver': idReceiver,
      'content': content,
      'timestamp' : timestamp
    };
  }


  factory Message.fromMap(Map<String, dynamic> data){
    return Message(
      idSender: data['idSender'],
      idReceiver: data['idReceiver'],
      content: data['content'],
        timestamp: data['timestamp']
    );
  }
}