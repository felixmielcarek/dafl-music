import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({Key? key}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF141414),
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 20,),
            Text("Max"),

          ],
        ),

        backgroundColor: Color(0xFF141414),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF141414),
              height: height*0.76,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Message('Adolescebat autem obstinatum propositum erga haec et similia multa scrutanda, stimulos admovente regina, quae abrupte mariti fortunas trudebat in exitium praeceps, cum eum potius lenitate feminea ad veritatis humanitatisque viam reducere utilia suadendo deberet, ut in Gordianorum actibus factitasse Maximini truculenti illius imperatoris rettulimus coniugem.', 0),
                  Message('Claudiopolis olim Seleucia Caesar potens quidem olim interneciva enim et.', 1),
                  Message('Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.', 1),
                  Message('Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.', 0),
                  Message('Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.', 0),
                  Message('Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.', 1),
                ],
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Container(
                  height: height*0.08,
                  color: Color(0xFF141414),
                  width: width*0.8,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,

                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Envoyer un message..."
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                  ),
                  child: Icon(Icons.send, size: 20, color: Colors.white,),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Message(String message, int user) {
    if(user == 0){
      return Container(
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:       Text(message,style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 19, fontWeight: FontWeight.w400),
            )),
      );
    }
    else{
      return Container(
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:       Text(message,style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 19, fontWeight: FontWeight.w400),
            )),
      );
    }


  }
}
