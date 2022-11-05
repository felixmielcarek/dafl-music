import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'p_main.dart';

class TopsWidget extends StatefulWidget {
  const TopsWidget({Key? key}) : super(key: key);

  @override
  State<TopsWidget> createState() => _TopsWidgetState();
}

class _TopsWidgetState extends State<TopsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color(0xFF141414),

      child: Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Les Tops', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  Text('Retrouvez ici les titres les plus écoutés', style: TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 15),),
                ],
              ),
            ),
            Expanded(child: ListView(
              children: [
                TopWidget(),
                TopWidget(),
                TopWidget(),
                TopWidget(),
                TopWidget(),
                TopWidget(),
              ],
            )),

          ],
        ),),
    );
  }

}

class TopWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      width: double.infinity,
      height: 200,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            clipBehavior: Clip.none,
            children: [
              Positioned(child: Icon(FontAwesomeIcons.champagneGlasses,size: 50,color: Colors.white,),
                right: 20,
                top: -15,),
              Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFD9D9D9).withOpacity(0.16),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text('Pour mon mariage',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                  )
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage.assetNetwork(
                      height: 120,
                      width: 120,
                      placeholder: "assets/images/loadingPlaceholder.gif", image: 'https://images.genius.com/ef4849be3da5fdb22ea9e656679be3a3.600x600x1.jpg'),
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 5, 80, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BAMBINA', style: TextStyle(fontSize:25, fontWeight: FontWeight.w700, color: Colors.white),),
                        Text('PNL', style: TextStyle(fontSize:20, fontWeight: FontWeight.w400, color: Colors.grey),),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                      right: 0,
                      child: Row(
                        children: [
                          GradientText(
                            '7,2%',
                            style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                            gradient: LinearGradient(colors: [
                              Colors.orange,
                              Colors.red,
                              Colors.purple,
                            ]),
                          ),
                        ],
                      ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
