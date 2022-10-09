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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141414),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/image_blur.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
                Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/pochette.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.fromLTRB(30, 87, 30, 0),
                height: 565,
                child: Stack(children:
                pileCarte,
                ),
              ) ,
              Container(
                margin: EdgeInsets.all(30),
                height: 100,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                height: 100,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                height: 100,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                height: 100,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                height: 100,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
                height: 100,
                color: Colors.blue,
              ),
            ],
          ),
          Stack(
            children: [
              Container(height: 200,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )

                ),),
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
        ],
      ),
    );
  }
}
