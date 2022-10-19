import 'package:flutter/material.dart';
import '../../assets/icons/icons.dart';
import './w_settings.dart';
import './w_spot.dart';
import './w_discovery.dart';
import './w_profil.dart';
import 'package:flutter/cupertino.dart';

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
    NavigationDestination(icon: Icon(CustomIcons.Spots_outline, color: Colors.grey), selectedIcon: Icon(CustomIcons.Spots, color: Colors.white), label: 'Spots',),
    NavigationDestination(icon: Icon(CustomIcons.podium_outine, color: Colors.grey,), label: 'Tops', selectedIcon: Icon(CustomIcons.podium, color: Colors.white,),),
    NavigationDestination(icon: Icon(Icons.mail_outline, color: Colors.grey,), label: 'Messages', selectedIcon: Icon(Icons.email, color: Colors.white,),),
    ],
    ),
      ),
      ),
    );
  }
}
