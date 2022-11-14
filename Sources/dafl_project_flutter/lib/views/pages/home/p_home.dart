import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import '../sign_in/p_sign_in.dart';
import '../sign_up/p_sign_up.dart';

class HomePage extends StatefulWidget {
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
              Spacer(),
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
                    backgroundColor: const Color(0xFF24CF5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ), // background// foreground
                  ),
                  onPressed: () {},
                  child: const Text(
                    "CONTINUER AVEC SPOTIFY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              SizedBox(
                height: height * 0.08,
              ),
              SizedBox(
                height: 55,
                width: width * 0.75,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C1DC3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ), // background// foreground
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
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
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),
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
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "SE CONNECTER",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: double.infinity,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF232123),
                    border: Border(
                      top: BorderSide(width: 1.5, color: Color(0xFF3C3C3C)),
                    ), // Set rounded corner radius
                  ),
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text(
                  "v1.0",
                  style: TextStyle(
                      fontFamily: 'DMSans',
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              )),
        ],
      ),
    );
  }
}