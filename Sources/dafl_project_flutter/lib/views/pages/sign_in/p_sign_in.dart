import 'dart:ui';
import 'package:dafl_project_flutter/model/user.dart';
import 'package:dafl_project_flutter/views/pages/main/p_main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../main.dart';
import '../../../model/music.dart';
import '../../../model/spot.dart';
import '../sign_up/p_sign_up.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var boxColor = Colors.white;

  @override
  bool isChecked = false;
  final userNameTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF141414),
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

              Image.asset(
                'assets/images/Logo.png',
                width: 250,
              ),
              SizedBox(height: 80,),
              Text(
                "SE CONNECTER",
                style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 23, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Container(
                width: 500,
                padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
                child: Stack(
                  children: [
                    Container(
                      height: 43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                      child: TextField(
                        controller: userNameTextField,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 12, 0, 0),
                      child: Image.asset(
                        'assets/images/profil_logo.png',
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )
              ),
              Container(
                  width: 500,
                  padding: EdgeInsets.fromLTRB(45, 10, 45, 0),
                  child: Stack(
                    children: [
                      Container(
                        height: 43,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],

                        ),

                      ),Padding(padding: EdgeInsets.fromLTRB(50, 0, 20, 0),
                        child: TextField(
                          controller: passwordTextField,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.purple,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 12, 0, 0),
                        child: Image.asset(
                          'assets/images/password_logo.png',
                          height: 16,
                          width: 16,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xFF951DDE),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      "se souvenir de moi",
                      style: TextStyle(fontFamily: 'DMSans', color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50,),
              ClipRRect(
                borderRadius: BorderRadius.circular(22),

                child: Material(

                  child: InkWell(
                    highlightColor: Colors.grey.shade100,
                    splashColor: Color(0xFF406DE1),
                    onTap: (){
                      checkInformations(userNameTextField.text, passwordTextField.text);
                    },
                    child:Ink(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.check,
                          color: Color(0xFF406DE1),
                          size: 60.0,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: 83,
                      height: 83,
                      decoration: BoxDecoration(
                        color: Colors.white,// Set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
              SizedBox(height: 100,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tu n’as pas de compte ?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 17)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageTransition(
                              type: PageTransitionType.fade,
                              childCurrent: widget,
                              child: SignUpPage()),
                        );
                      },
                      child: Text(' s’inscrire', style: TextStyle(color: Color(0xFF406DE1), fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    ),
                  ],
                ),
              SizedBox(height: 60,),
            ],
          ),

        ],
      ),
    );
  }

  void checkInformations(String username,String password){
    if(username ==""){
      Notify(2, context);
    }
    else if(password ==""){
      Notify(4, context);
    }
    else{
      //MyApp().controller.load(userNameTextField.text, passwordTextField.text);
      MyApp().controller.currentUser = User(userNameTextField.text, passwordTextField.text);
      MyApp().controller.currentUser.Spots2 = [
        Spot( User('Félix','1234'), Music('Couleurs','Khali','https://khaligidilit.com/assets/images/cover-LAI%CC%88LA-Khali.jpeg')),
        Spot( User('Audric','1234'), Music("J'suis PNL",'PNL','https://m.media-amazon.com/images/I/61aUOMzwS8L._SL1440_.jpg')),
        Spot( User('Dorian','1234'), Music('Sundance','Nepal','https://pbs.twimg.com/media/ExJ-My-XMAE3Ko2.jpg')),
        Spot( User('Lucas','1234'), Music('Eternelle 2','So La Lune','https://cdns-images.dzcdn.net/images/cover/2818a661c6d533155ce6dffc256b1f51/500x500.jpg')),
        Spot( User('David','1234'), Music('M.I.L.S 3','Ninho','https://cdns-images.dzcdn.net/images/cover/b351f0e935c9c3901f8d893b92ab952a/500x500.jpg')),
        Spot( User('Hugo','1234'), Music('Deux frères','PNL','https://cdns-images.dzcdn.net/images/cover/65147b581f2ace9e0f0723ee76e70fda/500x500.jpg')),
        Spot( User('Alban','1234'), Music('Paradis','Sopico','https://cdns-images.dzcdn.net/images/cover/17a9747927ac3e5ea56f92f635d9180c/500x500.jpg')),
      ].reversed.toList();
      Navigator.of(context).push(
        PageTransition(
            type: PageTransitionType.fade,
            childCurrent: widget,
            child: Splash()),
      );

      }
  }
}
