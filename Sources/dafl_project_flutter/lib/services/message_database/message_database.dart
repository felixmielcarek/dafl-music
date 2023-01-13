import 'package:dafl_project_flutter/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MessageDatabase{


  void SendMessage(String chatId, Message message) {
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(chatId)
        .collection(chatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference,message.toHashMap());
    });
  }

}