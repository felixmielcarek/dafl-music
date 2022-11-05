import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibration/vibration.dart';
import 'dart:math';
import './views/pages/home/p_home.dart';
import './views/pages/main/p_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}

enum CardStatus { like, disLike, discovery, message }

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }

  void resetUsers() {
    _urlImages = <String>[
      'https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg',
      'https://m.media-amazon.com/images/I/61aUOMzwS8L._SL1440_.jpg',
      'https://pbs.twimg.com/media/ExJ-My-XMAE3Ko2.jpg',
      'https://cdns-images.dzcdn.net/images/cover/2818a661c6d533155ce6dffc256b1f51/500x500.jpg',
      'https://cdns-images.dzcdn.net/images/cover/b351f0e935c9c3901f8d893b92ab952a/500x500.jpg',
      'https://cdns-images.dzcdn.net/images/cover/65147b581f2ace9e0f0723ee76e70fda/500x500.jpg',
      'https://cdns-images.dzcdn.net/images/cover/173b96be8ac025fb9578b0139010bc80/500x500.jpg',
      'https://cdns-images.dzcdn.net/images/cover/17a9747927ac3e5ea56f92f635d9180c/500x500.jpg',
    ].reversed.toList();

    notifyListeners();
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition(context) {
    _isDragging = false;
    notifyListeners();

    final status = getStatus(force: true);

    switch (status) {
      case CardStatus.like:
        like(context);
        break;
      case CardStatus.disLike:
        dislike();
        break;
      case CardStatus.discovery:
        discovery();
        break;
      case CardStatus.message:
        message(context);
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  double getStatusOpacity() {
    final delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceDiscovery = x.abs() < 80;
    final forceMessage = x.abs() < 100;

    if (force) {
      final delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.disLike;
      } else if (y <= -delta / 2 && forceDiscovery) {
        return CardStatus.message;
      } else if (y >= delta * 2 && x.abs() < 100) {
        return CardStatus.discovery;
      }
    } else {
      final delta = 20;

      if (y <= -delta * 2 && forceDiscovery) {
        return CardStatus.message;
      } else if (y >= delta * 2 && x.abs() < 80) {
        return CardStatus.discovery;
      } else if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.disLike;
      }
    }
  }

  void dislike() {
    Vibration.vibrate(duration: 20, amplitude: 60);
    print("dislike");
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void discovery() {
    Vibration.vibrate(duration: 20, amplitude: 60);
    print("discovery");
    _angle = 0;
    _position -= Offset(0, -_screenSize.height);
    _discovery_card();
    Fluttertoast.showToast(
        msg: 'Ajouté',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white);

    notifyListeners();
  }

  void message(context) {
    Vibration.vibrate(duration: 20, amplitude: 60);
    print("message");
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _message_card();
    showModalBottomSheet(
      isDismissible: false,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      constraints: BoxConstraints(
        maxWidth: 600,
        maxHeight: double.infinity,
      ),
      builder: (context) => buildSheet(),
    );
    notifyListeners();
  }

  Widget buildSheet() => Container(
        height: 550,
        width: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(
                0,
                0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow//BoxShadow
          ],
          color: Color(0xFF232123),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF8A8A8A),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF302C30),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    maxLength: 300,
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 17,
                        fontWeight: FontWeight.w200),
                    expands: true,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: "Mon message",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF3F1DC3),
                    textStyle:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Envoyer"),
                      Opacity(
                        opacity: 0.2,
                        child: Image.asset(
                          "assets/images/send_logo.png",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  void like(context) {
    Vibration.vibrate(duration: 20, amplitude: 60);
    print("like");
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }

  Future _nextCard() async {
    if (_urlImages.isEmpty) return;

    await Future.delayed(Duration(milliseconds: 200));
    _urlImages.removeLast();
    resetPosition();
  }

  Future _discovery_card() async {
    await Future.delayed(Duration(milliseconds: 200));
    resetPosition();
  }

  Future _message_card() async {
    await Future.delayed(Duration(milliseconds: 200));
    resetPosition();
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: RiveAnimation.asset('assets/images/new_file (2).riv'),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
