import 'package:dafl_project_flutter/views/pages/main/p_conversation.dart';
import 'package:dafl_project_flutter/views/pages/main/p_main.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:page_transition/page_transition.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  int indexSectedButton = 0;
  Widget listeActuelle = ListConfirmedWidget();


  var colorConfirm = Color(0xFFFFFFFF);
  var colorWaiting = Color(0xFFA8A8A8);
  void changeSelected(int num){
    if(indexSectedButton == num){
      return;
    }
    else{
      if(num == 0){
        setState((){
          colorConfirm = Color(0xFFFFFFFF);
          colorWaiting = Color(0xFFA8A8A8);
          listeActuelle = ListConfirmedWidget();
          indexSectedButton = num;
        });


      }
      else{
        setState((){
          colorConfirm = Color(0xFFA8A8A8);
          colorWaiting = Color(0xFFFFFFFF);
          listeActuelle = ListWaitingWidget();
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
      color: Color(0xFF141414),

      child: Padding(padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Messages', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25)),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  Text('Retrouvez ici vos discussions.', style: TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 15),),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, height*0.01, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 35,
                        width: width*0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorConfirm,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),// background// foreground
                          ),
                          onPressed: () {
                            changeSelected(0);
                          },
                          child: Text("Validées",
                            style: TextStyle(color: Colors.black ,fontSize: 17, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),),
                      SizedBox(
                        height: 35,
                        width: width*0.35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorWaiting,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),// background// foreground
                          ),
                          onPressed: () {
                            changeSelected(1);
                          },
                          child: Text("En attente",
                            style: TextStyle(color: Colors.black ,fontSize: 17, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),),
                    ],
                  ),),
                ],
              ),
            ),
            Expanded(
              child:
                listeActuelle,


            ),
          ],
        ),),
    );
  }
}

class MessagesButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [

            Container(
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://www.goutemesdisques.com/uploads/tx_gmdchron/pi1/L_Etrange_Histoire_de_Mr_Anderson.jpg'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),),
                  Container(
                    width: width-160,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Max',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                            Text('1 jour(s)',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.8) ,fontSize: 15, fontWeight: FontWeight.w400),),
                          ],
                        ),
                        Text('A envoyé un musique.',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                      ],
                    ),),
                ],
              ),
            ),


          ],
        )
    );

  }
}

class ListConfirmedWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(

      children: [
        SizedBox(height: 40,),
        MessagesButtonWidget(),
        MessagesButtonWidget(),
        MessagesButtonWidget(),
        MessagesButtonWidget(),


      ],
    );

  }
}

class ListWaitingWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ListView(

      children: [
        SizedBox(height: 40,),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageTransition(
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                type: PageTransitionType.rightToLeftWithFade,
                childCurrent: context.widget,
                child: ConversationPage()));
          },
          child: MessagesButtonWidget(),
        ),

      ],
    );

  }
}