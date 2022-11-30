import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../presentation/custom_icons_icons.dart';
import './w_settings.dart';
import './w_spot.dart';
import './w_discovery.dart';
import './w_profile.dart';
import './w_messages.dart';
import 'w_top.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 2;

  int get index => _index;
  final screens = [
    const ProfileWidget(),
    const DiscoveryWidget(),
    const SpotsWidget(),
    const TopsWidget(),
    const MessagesWidget(),
    const SettingsWidget(),
  ];

  @override
  void initState() {
    MyApp.controller.beginRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[_index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF5C1DC3),
          labelTextStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxHeight: 100,
          ),
          child: NavigationBar(
            animationDuration: const Duration(microseconds: 800),
            selectedIndex: index,
            height: height * 0.1,
            onDestinationSelected: (index) => setState(() => _index = index),
            backgroundColor: const Color(0xFF232123),
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                label: 'Profil',
                selectedIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              NavigationDestination(
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.grey,
                  ),
                  selectedIcon: Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                  label: 'Discovery'),
              NavigationDestination(
                icon: Icon(CustomIcons.spot, color: Colors.grey),
                selectedIcon:
                    Icon(CustomIcons.spotOutline, color: Colors.white),
                label: 'Spots',
              ),
              NavigationDestination(
                icon: Icon(
                  CustomIcons.podiumOutline,
                  color: Colors.grey,
                ),
                label: 'Tops',
                selectedIcon: Icon(
                  CustomIcons.podium,
                  color: Colors.white,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.mail_outline,
                  color: Colors.grey,
                ),
                label: 'Messages',
                selectedIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
