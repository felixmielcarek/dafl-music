import 'package:dafl_project_flutter/main.dart';
import 'package:dafl_project_flutter/model/user.dart';
import 'package:dafl_project_flutter/views/pages/main/w_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:dafl_project_flutter/model/message.dart';


class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {


  User destinataire = new User("test1", '1234');
  List<Widget> messages= [];
  bool isNull = true;

  final messageTextField = TextEditingController();


  void SendMessage(String content){
    setState(() {
      messages.add(MessageWidget(Message(MyApp().controller.currentUser,content)));
      messages.add(MessageWidget(Message(destinataire,"reponse test gyegryzgrgz zyegruhzb hvhbzy vhu ry z yrzrv ze vhv hzvh z zv zz ev")));
    });
  }
  Widget MessageWidget(Message message) {
    if(message.sender != MyApp().controller.currentUser){
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(40, 7, 80, 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            border: Border.all(width: 1.5,
                color: Color(0xFF9C9C9C).withOpacity(0.3)),
            color: Color(0xFF191919),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child:       Text(message.content,style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 15, fontWeight: FontWeight.w400),
              )),
        ),
      );
    }
    else{
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.fromLTRB(80, 7, 40, 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Color(0xFF2F2F2F),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text(message.content,style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 15, fontWeight: FontWeight.w400),),
          ),),
      );
    }


  }

  @override
  void initState() {

    super.initState();
    messageTextField.addListener(_checkIfNull);
    print("INITSATE");
  }

  @override
  void dispose() {
    messageTextField.dispose();
    super.dispose();
  }

  void _checkIfNull(){
    if(messageTextField.text.length > 0){
      setState(() {
        isNull = false;
      });
    }
    else{
      setState(() {
        isNull = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ScrollController listScrollController = ScrollController();


    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF141414),
        toolbarHeight: 70,
        title: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 20,),
              Text("Max"),

            ],
          ),
        ),

        elevation: 0,
      ),
      body: SingleChildScrollView(
        child:
            Container(
              color: Color(0xFF141414),
              height: height*0.92,
              width: double.infinity,
              child: /*ListView(
                reverse: true,
                scrollDirection: Axis.vertical,
                children: [
                  messages;
                ],
              ),*/
              ListView.builder(
                controller: listScrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messages[index];
                  })

            ),
      ),
      bottomSheet: BottomAppBar(
        color: Color(0xFF141414),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              height: height*0.08,
              color: Colors.transparent,
              width: width*0.9,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Color(0xFF2F2F2F),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xFF141414),

                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    controller: messageTextField,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        hintText: "Envoyer un message...",
                    ),
                    cursorColor: Colors.purple,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: isNull?
                  null:
                  () {

                  SendMessage(messageTextField.text);
                  if (listScrollController.hasClients) {
                    final position = listScrollController.position.maxScrollExtent;
                    listScrollController.jumpTo(position+40);
                  }
                  messageTextField.clear();

                },
              child: isNull == true?
              Container(
                height: 1,
                width: 1,
              ):
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: LinearGradient(
                    colors: [Color(0xff8e24a1), Color(0xff8163ff)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )


                ),
                child: Transform.rotate(angle: -300,
                child: Icon(Icons.arrow_back, size: 26, color: Colors.white,),)
              ),
            )
          ],
        ),
      ),

    );
  }
}
