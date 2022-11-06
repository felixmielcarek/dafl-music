import 'user.dart';

class Message{
  User sender;
  String content;


  @override
  String toString() => "$sender : $content";

  Message(this.sender, this.content);
}