import 'dart:ui';
import './w_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/gradient.dart' as gradiant;
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'package:rive/rive.dart';
import 'package:animations/animations.dart';

class Spots extends StatefulWidget {
  const Spots({Key? key}) : super(key: key);

  @override
  State<Spots> createState() => _SpotsState();
}

class _SpotsState extends State<Spots> {

  final user = User(
    chanteur: 'Khali',
    titre: 'COULEURS',
    urlImage: 'https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg',
  );
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final provider = Provider.of<CardProvider>(context);
    return Scaffold(

      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141414),
      body: Container(
        height: double.maxFinite,
        child: Stack(
          children: [
            Transform.scale(scale: 1.1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(provider.urlImages.isEmpty != true
                      ?provider.urlImages.last
                      :"https://i.imgur.com/Uovh293.png"),
                  fit: BoxFit.cover,

                ),
              ),
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                ),),
            ),),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0,height*0.03),
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
            Center(
              child: Container(
                width: 300,
                height: 300,
                child: RiveAnimation.asset('assets/images/search_spot_animation.riv'),
              ),
            ),
            Positioned(
              top: height*0.68,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      final provider = Provider.of<CardProvider>(context, listen:  false);
                      provider.dislike();

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
                    onTap: () {
                      final provider = Provider.of<CardProvider>(context, listen:  false);
                      provider.discovery();
                    },
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
                    onTap: () {
                      final provider = Provider.of<CardProvider>(context, listen:  false);
                      provider.like();
                    },
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
            Align(
                  child:Container(
                    width: 400,
                    height: height*0.8,
                    margin: EdgeInsets.fromLTRB(width*0.09,height/5,width*0.09,height/3.7),

                    child: Container(
                      child: buildCards(),
                    )
                  ) ,
                ),
            IgnorePointer(child: Container(height: 200,
              decoration: BoxDecoration(
                  gradient: gradiant.LinearGradient(
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
      )
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;

    return Stack(
      children: urlImages
          .map((urlImage) => DaflCard(
          urlImage: urlImage,
          isFront: urlImages.last == urlImage,
      ))
          .toList(),
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
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height*0.06,
      constraints: BoxConstraints(minWidth: 300, maxWidth: 400),
      margin: EdgeInsets.fromLTRB(width*0.1, 0, width*0.1, 0),
      decoration: BoxDecoration(
        color: Color(0xFF24243A).withOpacity(0.40),
        border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
          borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text('Me découvrir...',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 17, fontWeight: FontWeight.w800),),
         ],
      ),
    );

  }
}
