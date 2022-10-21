import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter/material.dart';

class DiscoveryWidget extends StatefulWidget {
  const DiscoveryWidget({Key? key}) : super(key: key);

  @override
  State<DiscoveryWidget> createState() => _DiscoveryWidgetState();
}

class _DiscoveryWidgetState extends State<DiscoveryWidget> {

  @override

  Widget build(BuildContext context) {
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
                  Row(
                      children: [
                        Text('Playlist découverte', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),),
                        Spacer(),
                        Icon(FontAwesome5.sort_amount_down, size: 30, color: Colors.white,),
                      ]
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  Text('Retrouvez ici vos nouvelles découvertes.', style: TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 15),),
                ],
              ),
            ),
            Expanded(
              child: ListView(

                children: [
                  SizedBox(height: 40,),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    child: FadeInImage.assetNetwork(placeholder: "assets/images/loadingPlaceholder.gif", image: 'https://www.goutemesdisques.com/uploads/tx_gmdchron/pi1/L_Etrange_Histoire_de_Mr_Anderson.jpg'),
                                  ),),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('IVERSON',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                                      Text('Laylow',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                                    ],
                                  ),),
                              ],
                            ),
                          ),


                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    child: FadeInImage.assetNetwork(placeholder: "assets/images/loadingPlaceholder.gif", image: 'https://www.goutemesdisques.com/uploads/tx_gmdchron/pi1/L_Etrange_Histoire_de_Mr_Anderson.jpg'),
                                  ),),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('IVERSON',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                                      Text('Laylow',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                                    ],
                                  ),),
                              ],
                            ),
                          ),


                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    child: FadeInImage.assetNetwork(placeholder: "assets/images/loadingPlaceholder.gif", image: 'https://www.goutemesdisques.com/uploads/tx_gmdchron/pi1/L_Etrange_Histoire_de_Mr_Anderson.jpg'),
                                  ),),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('IVERSON',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                                      Text('Laylow',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                                    ],
                                  ),),
                              ],
                            ),
                          ),


                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                    child: FadeInImage.assetNetwork(placeholder: "assets/images/loadingPlaceholder.gif", image: 'https://www.goutemesdisques.com/uploads/tx_gmdchron/pi1/L_Etrange_Histoire_de_Mr_Anderson.jpg'),
                                  ),),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('IVERSON',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                                      Text('Laylow',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                                    ],
                                  ),),
                              ],
                            ),
                          ),


                        ],
                      )
                  ),


                ],
              ),
            ),
          ],
        ),),
    );
  }
}
