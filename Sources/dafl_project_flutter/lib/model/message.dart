import 'user.dart';

class Message{
  User sender;
  String content;

  Message(this.sender,this.content);

  @override
  String toString() => "$sender : $content";
}