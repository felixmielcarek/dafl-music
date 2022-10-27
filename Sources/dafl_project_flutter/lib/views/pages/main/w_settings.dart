import 'package:dafl_project_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final userNameTextField = TextEditingController(text: MyApp().controller.currentUser?.usernameDafl);
  final passwordTextField = TextEditingController(text: MyApp().controller.currentUser?.passwDafl);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF141414),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.keyboard_arrow_left, color: Colors.grey.withOpacity(0.7), size: 50,),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(30, height*0.07, 30, 0),
                width: double.infinity,
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9).withOpacity(0.16),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('Pseudo',
                    style: TextStyle(
                        color: Color(0xFFAEAEAE)
                    ),),
                )
            ),
            Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: userNameTextField,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                          hintText: 'Pseudonyme',
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
                        MyApp().controller.changeUsernameCourant(userNameTextField.text);
                      },
                    child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Text('modifier',
                        style: TextStyle( color: Colors.blue, fontSize: 17),),),)


                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                width: double.infinity,
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9).withOpacity(0.16),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text('Mot de passe',
                    style: TextStyle(
                        color: Color(0xFFAEAEAE)
                    ),),
                )
            ),
            Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: passwordTextField,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                          hintText: 'Mot de passe',
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text('modifier',
                          style: TextStyle( color: Colors.blue, fontSize: 17),),),
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

