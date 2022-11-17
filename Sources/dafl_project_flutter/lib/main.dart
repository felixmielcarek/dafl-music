import 'dart:async';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import './views/pages/home/p_home.dart';
import './views/pages/main/p_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as riv;
import '../controller/controller.dart';
import 'model/spot.dart';
import 'model/user.dart';
import 'api/api.dart';
import 'dart:developer' as dev;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static Controller controller = Controller();
  static Api api = Api();

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Paint.enableDithering = true;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: HomePage(),
        ));
  }
}

enum CardStatus { like, disLike, discovery, message }

class CardProvider extends ChangeNotifier {
  final List<Spot> _spotsList = MyApp.controller.currentUser.spots;
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  List<Spot> get spotsList => _spotsList;

  bool get isDragging => _isDragging;

  Offset get position => _position;

  double get angle => _angle;

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
        discovery(context);
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
    const delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  CardStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceDiscovery = x.abs() < 80;

    if (force) {
      const delta = 100;

      if (x >= delta) {
        return CardStatus.like;
      } else if (x <= -delta) {
        return CardStatus.disLike;
      } else if (y <= -delta / 2 && forceDiscovery) {
        return CardStatus.message;
      } else if (y >= delta * 2 && x.abs() < 100) {
        return CardStatus.discovery;
      }
    }
    const delta = 20;

    if (y <= -delta * 2 && forceDiscovery) {
      return CardStatus.message;
    } else if (y >= delta * 2 && x.abs() < 80) {
      return CardStatus.discovery;
    } else if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.disLike;
    }
    return null;
  }

  void dislike() {
    dev.log("dislike");
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextCard();

    notifyListeners();
  }

  void discovery(BuildContext context) {
    dev.log("discovery");
    _angle = 0;
    _position -= Offset(0, -_screenSize.height);
    _discoveryCard();
    dev.log("discovery");
    showToastWidget(
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
          child: new Container(
            width: 300.0,
            height: 70.0,
            decoration: new BoxDecoration(
              color: Colors.grey.shade900.withOpacity(0.7),
            ),
            child: new Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyApp.controller.currentUser.discovery
                        .contains(MyApp.controller.currentUser.spots.last.music)
                    ? Icon(
                        Icons.info_rounded,
                        size: 40,
                        color: Colors.grey,
                      )
                    : Icon(
                        Icons.check_rounded,
                        size: 40,
                        color: Colors.grey,
                      ),
                SizedBox(
                  width: 10,
                ),
                MyApp.controller.currentUser.discovery
                        .contains(MyApp.controller.currentUser.spots.last.music)
                    ? Text(
                        "Déjà dans vos discovery",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )
                    : Text(
                        "Ajouté à discovery",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
              ],
            )),
          ),
        ),
      ),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 1500),
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );
    if (!MyApp.controller.currentUser.discovery
        .contains(MyApp.controller.currentUser.spots.last.music)) {
      MyApp.controller.currentUser
          .addDiscovery(MyApp.controller.currentUser.spots.last.music);
      notifyListeners();
    }
  }

  void message(context) {
    dev.log("message");
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
    _messageCard();
    showModalBottomSheet(
      isDismissible: false,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      constraints: const BoxConstraints(
        maxWidth: 600,
        maxHeight: double.infinity,
      ),
      builder: (context) => buildSheet(context),
    );
    notifyListeners();
  }

  Widget buildSheet(context) {
    final messageTextField = TextEditingController();
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 500,
        width: 380,
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
          color: const Color(0xFF232123),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF8A8A8A),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF302C30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    keyboardAppearance: Brightness.dark,
                    controller: messageTextField,
                    maxLength: 300,
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 17,
                        fontWeight: FontWeight.w200),
                    expands: true,
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: "Mon message",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    sendMessage(messageTextField.text,
                        MyApp.controller.currentUser.spots.last.user);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F1DC3),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Envoyer"),
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
      ),
    );
  }

  void sendMessage(String message, User destinataire) {
    dev.log(MyApp.controller.currentUser.spots.last.user.usernameDafl);
  }

  void like(context) {
    dev.log("like");
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }

  Future _nextCard() async {
    dev.log(_spotsList.length.toString());
    if (_spotsList.isEmpty) {
      dev.log('dernier');
      return;
    } else {
      await Future.delayed(const Duration(milliseconds: 200));
      dev.log(_spotsList.last.music.name);
      _spotsList.removeLast();
      resetPosition();
    }
  }

  Future _discoveryCard() async {
    await Future.delayed(const Duration(milliseconds: 200));
    resetPosition();
  }

  Future _messageCard() async {
    await Future.delayed(const Duration(milliseconds: 200));
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
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainPage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF141414),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
              SizedBox(
                height: 300,
                width: 300,
                child:
                    riv.RiveAnimation.asset('assets/images/new_file (2).riv'),
              ),
              SizedBox(height: 50),
            ])));
  }
}

Object notify(int index, context, {bool isError = true}) {
  double height = MediaQuery.of(context).size.height;
  String message;
  if (isError == true) {
    switch (index) {
      case 0:
        {
          message = "Ce nom d'utilisateur existe déjà ! Veuillez réessayer.";
          break;
        }
      case 1:
        {
          message = "Mots de passe différents ! Veuillez réessayer.";
          break;
        }
      case 2:
        {
          message = "Identifiant incorrect ! Veuillez réessayer.";
          break;
        }
      case 3:
        {
          message =
              "Mot de passe incorrect ! Votre mot de passe doit contenir 8 caractères minimum.";
          break;
        }
      case 4:
        {
          message = "Mot de passe incorrect ! Veuillez réessayer.";
          break;
        }
      default:
        message =
            "Une erreur est survenue pendant l'inscription. Veuillez réessayer.";
        break;
    }
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, height / 110, 20, 0),
                height: 90,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/backgroundNotify.png"),
                      fit: BoxFit.cover),
                  gradient: const LinearGradient(
                      colors: [Color(0xFF81052a), Color(0xFF810548)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(4, 8), // Shadow position
                    ),
                  ],
                ),
                child: Row(children: [
                  const SizedBox(
                    height: 48,
                    width: 48,
                  ),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text(
                          "Ho ho !",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(message,
                            style: const TextStyle(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2)
                      ]))
                ])),
            Positioned(
                top: -50,
                left: -20,
                child: Container(
                  color: Colors.transparent,
                  height: 110,
                  width: 110,
                  child: const riv.RiveAnimation.asset(
                      "assets/images/error_icon.riv"),
                )),
          ],
        )));
  } else {
    switch (index) {
      case 0:
        {
          message = "Vous avez changer votre identifiant avec succès";
          break;
        }
      case 1:
        {
          message = "Vous avez changer votre mot de passe avec succès";
          break;
        }
      default:
        message = "L'opération a bien été éxécutée";
        break;
    }
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, height / 110, 20, 0),
              height: 90,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/valid_background.png"),
                    fit: BoxFit.cover),
                gradient: const LinearGradient(
                    colors: [Color(0xFF81052a), Color(0xFF810548)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(4, 8), // Shadow position
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(
                    height: 48,
                    width: 48,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Super !",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          style: const TextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: -50,
                left: -20,
                child: Container(
                  color: Colors.transparent,
                  height: 110,
                  width: 110,
                  child: const riv.RiveAnimation.asset(
                      "assets/images/valid_icon.riv"),
                )),
          ],
        )));
  }
}
