import 'message.dart';
import 'user.dart';
import 'dart:developer' as dev;

class Conversation {
  User firstUser;
  User secondUser;
  List<Message> messages = [];

  Conversation(this.firstUser, this.secondUser);

  void addMessage(User sender, String content) {
    messages.add(Message(sender, content));
  }

  void displayMessages() {
    dev.log("-----Conversation entre $firstUser et $secondUser-----");
    for (var element in messages) {
      dev.log(element.toString());
    }
  }
}
