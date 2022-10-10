import 'package:animations/animations.dart';
import 'package:daflmusic/dafl_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class Spots extends StatefulWidget {
  const Spots({Key? key}) : super(key: key);

  @override
  State<Spots> createState() => _SpotsState();
}

class _SpotsState extends State<Spots> {

  List<Widget> pileCarte = <Widget>[
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
    DaflCard(color: Colors.red),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141414),
      body: Container(
        height: double.maxFinite,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/image_blur.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],

                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        margin: EdgeInsets.fromLTRB(34, height*0.1, 34, 0),
                        height: height*0.66,
                        width: 565,
                        child: Stack(children:
                        pileCarte,
                        ),
                      ),
                    ),
                    IgnorePointer(child: Container(height: 200,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )

                      ),),),
                    Padding(padding: EdgeInsets.fromLTRB(20, 60, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('COULEURS',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                          Text('Khali',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 17, fontWeight: FontWeight.w200),),
                        ],
                      ),),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, height*0.03, 0,0),
                  child:  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: OpenContainer(

                      closedColor: Colors.transparent,
                      closedElevation: 0,
                      transitionDuration: Duration(milliseconds: 400),
                      closedBuilder: (context, openWidget){
                        return PreviewInfo();
                      },
                      openBuilder: (context, closeWidget){
                        return Destination();
                      },
                    ),
                  ),
                ),

              ],
            ),
        Positioned(
          top: height*0.71,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  pileCarte.remove(0);
                  print("remove");
                },
                child: Image.asset(
                  'assets/images/bouton_dislike.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: width*0.1,
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/images/bouton_discovery.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: width*0.1,
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/images/bouton_like.png',
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
          ],
        ),
      )
    );
  }
}

class Destination extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232123),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("J'aime aussi..."),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Column(
              children: [
                Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E2C2E),
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],

                  ),
                width: double.infinity,
                height: 100,
                child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/dadju-cover-poison.png"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),),
                    SizedBox(
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                          Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                        ],
                      ),),
                  ],
                ),),
              ),

              ],
            )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text('Pour mon mariage',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),

                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E2C2E),
                      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(2.0, 2.0), // shadow direction: bottom right
                        )
                      ],

                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/dadju-cover-poison.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),),
                        SizedBox(
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ma vie',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text('Dadju',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),),
                  ),

                ],
              )
          ),

        ],
      ),
    );
  }
}

class PreviewInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: 200,
      height: height*0.10,
      decoration: BoxDecoration(
        color: Color(0xFF24243A).withOpacity(0.24),
        border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
          borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text('Me découvrir...',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
         ],
      ),
    );

  }
}
