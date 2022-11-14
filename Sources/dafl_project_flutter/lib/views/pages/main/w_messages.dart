import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'p_conversation.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  int indexSectedButton = 0;
  Widget currentList = const ListConfirmedWidget();

  var colorConfirm = const Color(0xFFFFFFFF);
  var colorWaiting = const Color(0xFFA8A8A8);

  void changeSelected(int num) {
    if (indexSectedButton == num) {
      return;
    } else {
      if (num == 0) {
        setState(() {
          colorConfirm = const Color(0xFFFFFFFF);
          colorWaiting = const Color(0xFFA8A8A8);
          currentList = const ListConfirmedWidget();
          indexSectedButton = num;
        });
      } else {
        setState(() {
          colorConfirm = const Color(0xFFA8A8A8);
          colorWaiting = const Color(0xFFFFFFFF);
          currentList = const ListWaitingWidget();
          indexSectedButton = num;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xFF141414),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Messages',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25)),
                const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                Text(
                  'Retrouvez ici vos discussions.',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.4), fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 35,
                        width: width * 0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorConfirm,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ), // background// foreground
                          ),
                          onPressed: () {
                            changeSelected(0);
                          },
                          child: const Text(
                            "Validées",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                        width: width * 0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorWaiting,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ), // background// foreground
                          ),
                          onPressed: () {
                            changeSelected(1);
                          },
                          child: const Text(
                            "En attente",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: currentList,
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesButtonWidget extends StatelessWidget {
  const MessagesButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://www.goutemesdisques.com/uploads/tx_gmdchron/pi1/L_Etrange_Histoire_de_Mr_Anderson.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 0, color: Colors.grey.withOpacity(0)),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  Container(
                    width: width - 160,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Max',
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  color: Colors.white.withOpacity(1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '1 jour(s)',
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Text(
                          'A envoyé un musique.',
                          style: TextStyle(
                              fontFamily: 'DMSans',
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class ListConfirmedWidget extends StatelessWidget {
  const ListConfirmedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(
          height: 40,
        ),
        MessagesButtonWidget(),
        MessagesButtonWidget(),
        MessagesButtonWidget(),
        MessagesButtonWidget(),
      ],
    );
  }
}

class ListWaitingWidget extends StatelessWidget {
  const ListWaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const SizedBox(
        height: 40,
      ),
      GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageTransition(
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeftWithFade,
                childCurrent: context.widget,
                child: const ConversationPage()));
          },
          child: const MessagesButtonWidget())
    ]);
  }
}
