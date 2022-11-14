import 'package:flutter/material.dart';

import '../../../main.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  final userNameTextField = TextEditingController(text: MyApp().controller.currentUser.usernameDafl);
  final passwordTextField = TextEditingController(text: MyApp().controller.currentUser.passwDafl);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey.withOpacity(0.7),
            size: 50,
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(30, height * 0.07, 30, 0),
                width: double.infinity,
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.16),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Pseudo',
                    style: TextStyle(color: Color(0xFFAEAEAE)),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        controller: userNameTextField,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle:
                              Theme.of(context).textTheme.caption?.copyWith(
                                    color: Colors.white,
                                  ),
                          border: InputBorder.none,
                          hintText: 'Pseudonyme',
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        MyApp.controller
                            .changeUsernameCourant(userNameTextField.text);
                        notify(0, context, isError: false);
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          'modifier',
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                width: double.infinity,
                height: 30,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9).withOpacity(0.16),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Mot de passe',
                    style: TextStyle(color: Color(0xFFAEAEAE)),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                width: width,
                child: Row(
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        keyboardAppearance: Brightness.dark,
                        controller: passwordTextField,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle:
                              Theme.of(context).textTheme.caption?.copyWith(
                                    color: Colors.white,
                                  ),
                          border: InputBorder.none,
                          hintText: 'Mot de passe',
                        ),
                        cursorColor: Colors.purple,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        MyApp.controller
                            .changePasswordCourant(passwordTextField.text);
                        notify(1, context, isError: false);
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(
                          'modifier',
                          style: TextStyle(color: Colors.blue, fontSize: 17),
                        ),
                      ),
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
