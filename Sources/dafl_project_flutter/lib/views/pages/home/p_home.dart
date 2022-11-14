import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import '../sign_in/p_sign_in.dart';
import '../sign_up/p_sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
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
                const Spacer(),
                Image.asset(
                  'assets/images/Logo.png',
                  width: 230,
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                SizedBox(
                    height: 55,
                    width: width * 0.75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF951DDE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ) // background// foreground
                          ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeftJoined,
                              childCurrent: widget,
                              child: const SignUpPage()),
                        );
                      },
                      child: const Text(
                        "S’INSCRIRE MAINTENANT",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DMSans"),
                        textAlign: TextAlign.center,
                      ),
                    )),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageTransition(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeftJoined,
                          childCurrent: widget,
                          child: const SignInPage()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    width: double.infinity,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFF232123),
                      border: Border(
                        top: BorderSide(width: 1.5, color: Color(0xFF3C3C3C)),
                      ), // Set rounded corner radius
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "SE CONNECTER",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "DMSans",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ]),
        ],
      ),
    );
  }
}
