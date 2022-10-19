
import 'package:daflmusic/icons.dart';
import 'package:daflmusic/widgets/spots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:daflmusic/signInPage/main_signIn_page.dart';
import 'package:daflmusic/homePage/main_homepage.dart';
import 'package:daflmusic/signUpPage/main_signUp_page.dart';

import '../discoveryPage/discoveryPage.dart';
import '../profilPage/MainProfilPage.dart';
import '../profilPage/parametre_page.dart';

class MainMainPage extends StatefulWidget {
  const MainMainPage({Key? key}) : super(key: key);

  @override
  State<MainMainPage> createState() => _MainMainPageState();
}


class _MainMainPageState extends State<MainMainPage> {
  int _index = 2;
  int get index => _index;
  final screens = [
    MainProfilPage(),
    DiscoveryPage(),
    Spots(),
    Center(child: Text('Tops'),),
    Center(child: Text('Messages'),),
    ParametrePage(),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor:  Color(0xFF5C1DC3),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)
          ),
        ),
        child: ConstrainedBox(
    constraints: BoxConstraints(
    minHeight: height*0.1,
    maxHeight: 100,
    ),
    child: NavigationBar(
    animationDuration: Duration(seconds: 1),
    selectedIndex: index,
    height: height*0.1,
    onDestinationSelected: (index) =>
    setState(() => this._index = index),
    backgroundColor: Color(0xFF232123),
    destinations: [
    NavigationDestination(icon: Icon(Icons.person_outline, color: Colors.grey,), label: 'Profil', selectedIcon: Icon(Icons.person, color: Colors.white,),),
    NavigationDestination(icon: Icon(Icons.bookmark_border, color: Colors.grey,), selectedIcon: Icon(Icons.bookmark, color: Colors.white,), label: 'Discovery'),
    NavigationDestination(icon: Icon(MyFlutterApp.Spots_outline, color: Colors.grey), selectedIcon: Icon(MyFlutterApp.Spots, color: Colors.white), label: 'Spots',),
    NavigationDestination(icon: Icon(MyFlutterApp.podium_outine, color: Colors.grey,), label: 'Tops', selectedIcon: Icon(MyFlutterApp.podium, color: Colors.white,),),
    NavigationDestination(icon: Icon(Icons.mail_outline, color: Colors.grey,), label: 'Messages', selectedIcon: Icon(Icons.email, color: Colors.white,),),
    ],
    ),
      ),
      ),
    );
  }
}
