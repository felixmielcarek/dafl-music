import 'package:dafl_project_flutter/presentation/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import './w_settings.dart';
import './w_spot.dart';
import './w_discovery.dart';
import './w_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {
  int _index = 2;
  int get index => _index;
  final screens = [
    ProfilWidget(),
    new DiscoveryWidget(),
    SpotsWidget(),
    Center(child: Text('Tops'),),
    Center(child: Text('Messages'),),
    SettingsWidget(),
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
    setState(() => _index = index),
    backgroundColor: Color(0xFF232123),
    destinations: [
    NavigationDestination(icon: Icon(Icons.person_outline, color: Colors.grey,), label: 'Profil', selectedIcon: Icon(Icons.person, color: Colors.white,),),
    NavigationDestination(icon: Icon(Icons.bookmark_border, color: Colors.grey,), selectedIcon: Icon(Icons.bookmark, color: Colors.white,), label: 'Discovery'),
    NavigationDestination(icon: Icon(CustomIcons.spot, color: Colors.grey), selectedIcon: Icon(CustomIcons.spot_outline, color: Colors.white), label: 'Spots',),
    NavigationDestination(icon: Icon(CustomIcons.podium_outline, color: Colors.grey,), label: 'Tops', selectedIcon: Icon(CustomIcons.podium, color: Colors.white,),),
    NavigationDestination(icon: Icon(Icons.mail_outline, color: Colors.grey,), label: 'Messages', selectedIcon: Icon(Icons.email, color: Colors.white,),),
    ],
    ),
      ),
      ),
    );
  }
}
