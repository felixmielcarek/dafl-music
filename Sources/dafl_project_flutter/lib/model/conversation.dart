import 'message.dart';
import 'user.dart';

class Conversation{
  User firstUser;
  User secondUser;
  List<Message> messages=[];

  Conversation(this.firstUser,this.secondUser);

  void addMessage(User sender,String content){
    messages.add(Message(sender, content));
  }

  void displayMessages(){
    print("-----Conversation entre $firstUser et $secondUser-----");
    for (var element in messages) {
      print(element);
    }
  }
}