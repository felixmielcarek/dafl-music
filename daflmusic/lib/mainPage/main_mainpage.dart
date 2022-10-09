
import 'package:daflmusic/icons.dart';
import 'package:daflmusic/widgets/spots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:daflmusic/signInPage/main_signIn_page.dart';
import 'package:daflmusic/homePage/main_homepage.dart';
import 'package:daflmusic/signUpPage/main_signUp_page.dart';

class MainMainPage extends StatefulWidget {
  const MainMainPage({Key? key}) : super(key: key);

  @override
  State<MainMainPage> createState() => _MainMainPageState();
}

class _MainMainPageState extends State<MainMainPage> {
  int index = 2;

  final screens = [
    MainHomePage(),
    Draggable(child: Container(height: 200 , width: 300, color: Colors.grey,), feedback: Container(height: 200 , width: 300, color: Colors.black,)),
    Spots(),
    Center(child: Text('Tops'),),
    Center(child: Text('Messages'),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor:  Colors.deepPurple,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)
          ),
        ),
        child: NavigationBar(
          animationDuration: Duration(seconds: 1),
          selectedIndex: index,
          onDestinationSelected: (index) =>
              setState(() => this.index = index),
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
    );
  }
}
