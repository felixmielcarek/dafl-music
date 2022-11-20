import 'package:dafl_project_flutter/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MessageDatabaseServices{


  String _getChatId(String idSender, String idReceiver){
      if (idSender.hashCode <= idReceiver.hashCode)
        return '$idSender-${idReceiver}';
      else
        return '${idReceiver}-$idSender';

  }

  void sendMessage(Message message, String idSender, String idReceiver) {
    String chatId = _getChatId(idSender, idReceiver);

    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, message.toHashMap());
    });
  }

  Message _getMessage(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null)
      throw Exception("no data in database");

    return Message.fromMap(data);
  }


  List<Message> _getAllMessages(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _getMessage(doc);
    }).toList();
  }

  Stream<List<Message>> getMessage(String chatId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection(chatId)
        .snapshots().map(_getAllMessages);
  }
}