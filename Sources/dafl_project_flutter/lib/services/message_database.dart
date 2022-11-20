import 'package:dafl_project_flutter/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MessageDatabase{


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

}