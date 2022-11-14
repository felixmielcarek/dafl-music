import 'package:flutter/material.dart';

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
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF141414),
        toolbarHeight: 70,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text("Max"),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF141414),
          height: height * 0.92,
          width: double.infinity,
          child: ListView(
            reverse: true,
            scrollDirection: Axis.vertical,
            children: [
              message(
                  'Adolescebat autem obstinatum propositum erga haec et similia multa scrutanda, stimulos admovente regina, quae abrupte mariti fortunas trudebat in exitium praeceps, cum eum potius lenitate feminea ad veritatis humanitatisque viam reducere utilia suadendo deberet, ut in Gordianorum actibus factitasse Maximini truculenti illius imperatoris rettulimus coniugem.',
                  0),
              message(
                  'Claudiopolis olim Seleucia Caesar potens quidem olim interneciva enim et.',
                  1),
              message(
                  'Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.',
                  1),
              message(
                  'Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.',
                  0),
              message(
                  'Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.',
                  0),
              message(
                  'Quae quae praeceps feminea quae truculenti humanitatisque cum humanitatisque in truculenti abrupte imperatoris mariti regina regina ad lenitate veritatis veritatis.',
                  1),
            ],
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        color: const Color(0xFF141414),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.08,
              color: Colors.transparent,
              width: width * 0.8,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFF2F2F2F),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFF141414),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
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
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.send,
                size: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget message(String message, int user) {
    if (user == 0) {
      return Container(
        margin: const EdgeInsets.fromLTRB(40, 7, 80, 7),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          border: Border.all(
              width: 1.5, color: const Color(0xFF9C9C9C).withOpacity(0.3)),
          color: const Color(0xFF191919),
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Text(
              message,
              style: const TextStyle(
                  fontFamily: 'DMSans',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )),
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(80, 7, 40, 7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFF2F2F2F),
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Text(
              message,
              style: const TextStyle(
                  fontFamily: 'DMSans',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            )),
      );
    }
  }
}
