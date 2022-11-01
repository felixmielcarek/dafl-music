import 'dart:math';

import 'package:dafl_project_flutter/main.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter/material.dart';

import '../../../model/music.dart';

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

      child: Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
              child: MyApp().controller.currentUser.Discovery.isEmpty?
                    Center(child: Image.asset('assets/images/EmptyDiscovery-Hint.png',scale: 1.8,)):
                  DiscoveryList(),
            ),

          ],
        ),),
    );
  }
}

class DiscoveryList extends StatefulWidget {
  const DiscoveryList({Key? key}) : super(key: key);

  @override
  State<DiscoveryList> createState() => _DiscoveryListState();
}

class _DiscoveryListState extends State<DiscoveryList> {
   late GlobalKey<RefreshIndicatorState> refreshKey;
  @override
  void initState() {
    refreshKey = GlobalKey<RefreshIndicatorState>();
    refreshList();
    super.initState();
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      MyApp().controller.currentUser.Discovery;
    });
    return null;
  }
  Widget build(BuildContext context) {
    return RefreshIndicator(child: ListView.builder(
        itemCount: MyApp().controller.currentUser.Discovery.length ?? 0,
        itemBuilder: (context, index){
          int itemCount = MyApp().controller.currentUser.Discovery.length ?? 0;
          int reversedIndex = itemCount - 1 - index;
          return Dismissible(
            key: Key(MyApp().controller.currentUser.Discovery[reversedIndex].name),
            direction: DismissDirection.startToEnd,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                            child: FadeInImage.assetNetwork(placeholder: "assets/images/loadingPlaceholder.gif", image: MyApp().controller.currentUser.Discovery[reversedIndex].linkCover),
                          ),),
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(MyApp().controller.currentUser.Discovery[reversedIndex].name ?? '',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(1) ,fontSize: 20, fontWeight: FontWeight.w800),),
                              Text(MyApp().controller.currentUser.Discovery[reversedIndex].artist ?? '',style: TextStyle(fontFamily: 'DMSans', color: Colors.white.withOpacity(0.6) ,fontSize: 16, fontWeight: FontWeight.w400),),

                            ],
                          ),),
                      ],
                    ),
                  ),


                ],
              )

          ), onDismissed: (direction) {
            if(direction == DismissDirection.startToEnd)
              MyApp().controller.currentUser.Discovery.removeAt(reversedIndex);
          },
          background: Container(decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/delete_background.png"), fit: BoxFit.cover),
          )),);
        }
    ), onRefresh: () async {
      refreshList();
    }, key: refreshKey,);
  }
}
