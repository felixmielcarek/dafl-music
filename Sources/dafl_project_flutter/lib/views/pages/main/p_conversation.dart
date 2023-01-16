import 'package:flutter/material.dart';
import 'package:dafl_project_flutter/main.dart';
import 'package:dafl_project_flutter/model/user.dart';
import 'package:dafl_project_flutter/model/message.dart';
import 'dart:developer' as dev;

class ConversationPage extends StatefulWidget {
  String sender;

  ConversationPage({Key? key, required String this.sender}) : super(key: key);

  @override
  State<ConversationPage> createState() => _ConversationPageState(sender);
}

class _ConversationPageState extends State<ConversationPage> {
  String destinataire = 'test';
  List<Widget> messages = [];
  bool isNull = true;
  final String receiver;

  _ConversationPageState(this.receiver);

  final messageTextField = TextEditingController();

  void sendMessage(String content, String idSender, String idReceiver) {
    Message messageToSend = Message(idSender: idSender, idReceiver: idReceiver, content: content, timestamp: DateTime.now().toString());

    MyApp.controller.sendMessage(messageToSend, idSender, idReceiver);

    setState(() {
      messages.add(messageWidget(messageToSend));
    });
  }

  Widget messageWidget(Message message) {
    if (message.idSender != MyApp.controller.getIdDafl()) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
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
                message.content,
                style: const TextStyle(
                    fontFamily: 'DMSans',
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              )),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
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
            padding: const EdgeInsets.all(15),
            child: Text(
              message.content,
              style: const TextStyle(
                  fontFamily: 'DMSans',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    messageTextField.addListener(_checkIfNull);
    dev.log("INITSATE");
  }

  @override
  void dispose() {
    messageTextField.dispose();
    super.dispose();
  }

  void _checkIfNull() {
    if (messageTextField.text.isNotEmpty) {
      setState(() {
        isNull = false;
      });
    } else {
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
        elevation: 20,
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
            Text(receiver),
            const Spacer(),
            IconButton(
              splashColor: Colors.grey.withOpacity(0.2),
              splashRadius: 30,
              onPressed: () {
                showModalBottomSheet(
                  isDismissible: true,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                    maxHeight: double.infinity,
                  ),
                  builder: (context) => buildSheet(),
                );
              },
              icon: Icon(
                Icons.report_problem,
                color: Colors.grey.withOpacity(0.3),
                size: 25,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              color: const Color(0xFF141414),
              height: height * 0.92,
              width: double.infinity,
              child: Flexible(
                child: StreamBuilder<List<Message>>(
                  stream: MyApp.controller.getMessage(MyApp.controller.getIdDafl(), receiver),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Message>> snapshot) {
                    if (snapshot.hasData) {
                      List<Message> listMessage =
                          snapshot.data ?? List.from([]);
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) =>
                            messageWidget(listMessage[index]),
                        itemCount: listMessage.length,
                        reverse: true,
                        controller: listScrollController,
                      );
                    } else {
                      return Center(child: Container());
                    }
                  },
                ),
              ))),
      bottomSheet: BottomAppBar(
        color: const Color(0xFF141414),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: height * 0.08,
              color: Colors.transparent,
              width: width * 0.9,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFF2F2F2F),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFF141414),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: TextField(
                    controller: messageTextField,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle:
                      TextStyle(color: Colors.white.withOpacity(0.7)),
                      border: InputBorder.none,
                      hintText: "Votre message...",
                    ),
                    cursorColor: Colors.purple,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: isNull
                  ? null
                  : () {
                sendMessage(
                    messageTextField.text,
                    MyApp.controller.getIdDafl(),
                    receiver);
                if (listScrollController.hasClients) {
                  final position =
                      listScrollController.position.maxScrollExtent;
                  listScrollController.jumpTo(position);
                }
                messageTextField.clear();
              },
              child: isNull == true
                  ? const SizedBox(
                height: 1,
                width: 1,
              )
                  : Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                        colors: [Color(0xff8e24a1), Color(0xff8163ff)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  child: Transform.rotate(
                    angle: -300,
                    child: const Icon(
                      Icons.arrow_back,
                      size: 26,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSheet() {
    final messageTextField = TextEditingController();
    return SingleChildScrollView(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 500,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(
                0,
                0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow//BoxShadow
          ],
          color: const Color(0xFF232123),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 5,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF8A8A8A),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  'Signaler',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: const [
                    Text(
                      'Vous êtes sur le point de signaler cet utilisateur. Veuillez renseigner le motif du signalement.',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: DropdownButtonReason(),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: messageTextField,
                          keyboardAppearance: Brightness.dark,
                          style: TextStyle(
                              fontFamily: 'DMSans',
                              color: Colors.white.withOpacity(1),
                              fontSize: 17,
                              fontWeight: FontWeight.w200),
                          maxLines: 3,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            hintText: '* Commentaires',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      MyApp.controller.sendEmail(
                          MyApp.controller.getIdDafl().toString(),
                          destinataire,
                          currentValue,
                          messageTextField.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            top: -10,
                            right: 0,
                            child: Icon(
                              Icons.report,
                              size: 100,
                              color: Colors.white.withOpacity(0.2),
                            )),
                        const Center(
                          child: Text("Envoyer le signalement"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownButtonReason extends StatefulWidget {
  const DropdownButtonReason({super.key});

  @override
  State<DropdownButtonReason> createState() => _DropdownButtonReasonState();
}

const List<String> list = <String>[
  'Insulte',
  'Racisme',
  'Messages inappropriés',
  "Usurpation d'identité"
];

String currentValue = list[0];

class _DropdownButtonReasonState extends State<DropdownButtonReason> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Colors.grey.shade900.withOpacity(1),
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.grey,
      ),
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.grey.withOpacity(0.6),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          currentValue = value;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}