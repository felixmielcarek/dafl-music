import 'package:dafl_project_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../model/user.dart';
import '../../../services/api/in_app_browser.dart';
import '../home/p_home.dart';
import '../sign_in/p_sign_in.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Color boxColor = Colors.white;
  bool isHovering = false;
  bool isChecked = false;
  final userNameTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  final passwordConfirmTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF141414),
        body:
            Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
          Image.asset(
            'assets/images/background.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                  width: 250,
                ),
                const SizedBox(
                  height: 45,
                ),
                const Text(
                  "S'INSCRIRE",
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: 500,
                    padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                    child: Stack(
                      children: [
                        Container(
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                          child: TextField(
                            keyboardAppearance: Brightness.dark,
                            controller: userNameTextField,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.purple,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 12, 0, 0),
                          child: Image.asset(
                            'assets/images/profil_logo.png',
                            height: 16,
                            width: 16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
                Container(
                    width: 500,
                    padding: const EdgeInsets.fromLTRB(45, 10, 45, 0),
                    child: Stack(
                      children: [
                        Container(
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                          child: TextField(
                            keyboardAppearance: Brightness.dark,
                            controller: passwordTextField,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.purple,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 12, 0, 0),
                          child: Image.asset(
                            'assets/images/password_logo.png',
                            height: 16,
                            width: 16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
                Container(
                    width: 500,
                    padding: const EdgeInsets.fromLTRB(45, 10, 45, 0),
                    child: Stack(
                      children: [
                        Container(
                            height: 43,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ])),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
                          child: TextField(
                            obscureText: true,
                            controller: passwordConfirmTextField,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.purple,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 12, 0, 0),
                          child: Image.asset(
                            'assets/images/password_logo.png',
                            height: 16,
                            width: 16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
                Container(
                    width: 500,
                    padding: const EdgeInsets.fromLTRB(45, 10, 45, 0),
                    child: Stack(
                      children: [
                        Container(
                          height: 43,
                          decoration: BoxDecoration(
                            color: const Color(0xFF24CF5F),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 43,
                          width: width * 0.75,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF24CF5F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ), // background// foreground
                              ),
                              onPressed: () {
                                MyApp.controller.navigatorKey = context;
                                MyInAppBrowser();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Lier compte",
                                    style: TextStyle(
                                        fontFamily: 'DMSans',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Image.asset(
                                    'assets/images/spotify_logo.png',
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Material(
                    child: InkWell(
                      highlightColor: Colors.grey.shade100,
                      splashColor: const Color(0xFF406DE1),
                      onTap: () {
                        checkInformations(
                            userNameTextField.text,
                            passwordTextField.text,
                            passwordConfirmTextField.text);
                      },
                      child: Ink(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: 83,
                        height: 83,
                        decoration: BoxDecoration(
                          color: Colors.white, // Set rounded corner radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.check,
                            color: Color(0xFF406DE1),
                            size: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tu as déjà un compte ?',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 17)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              childCurrent: widget,
                              child: const SignInPage()),
                        );
                      },
                      child: const Text(
                        ' se connecter',
                        style: TextStyle(
                            color: Color(0xFF406DE1),
                            fontWeight: FontWeight.normal,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                )
              ])
        ]));
  }

  checkInformations(
      String username, String password, String confirmPassword) async {
    if (username == "") {
      notify(2, context);
    }
    /* else if (!await MyApp.controller.searchByUsername(username)) {
      notify(0, context);
    }*/
    if (password == "" || confirmPassword == "") {
      notify(4, context);
    } else if (password.length < 8) {
      notify(3, context);
    } else if (password != confirmPassword) {
      notify(1, context);
    } else {
      //MyApp.controller.save(User(username, password));

      Navigator.of(context).push(
        PageTransition(
            duration: const Duration(milliseconds: 300),
            reverseDuration: const Duration(milliseconds: 300),
            type: PageTransitionType.leftToRightJoined,
            childCurrent: widget,
            child: const HomePage()),
      );
    }
  }
}
