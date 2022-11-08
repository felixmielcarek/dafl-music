import 'package:dafl_project_flutter/main.dart';

import '../../../main.dart';
import '../../../main.dart';
import './w_settings.dart';
import './w_spot.dart';
import 'package:flutter/material.dart';

class ProfilWidget extends StatefulWidget {
  const ProfilWidget({Key? key}) : super(key: key);

  @override
  State<ProfilWidget> createState() => _ProfilWidgetState();
}

class _ProfilWidgetState extends State<ProfilWidget> {


  @override
  Widget build(BuildContext context) {

    return MainPageProfil();
  }
}

class MainPageProfil extends StatefulWidget {
  const MainPageProfil({Key? key}) : super(key: key);

  @override
  State<MainPageProfil> createState() => _MainPageProfilState();
}

class _MainPageProfilState extends State<MainPageProfil> {

  String? username = MyApp().controller.currentUser.usernameDafl;
  @override
  void initState() {
    super.initState();
    String username = MyApp().controller.currentUser.usernameDafl ?? "default";
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xFF141414),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(30, 50, 0, 0),
              child: Text(
                "Profil",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: "DMSans"),),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              height: height*0.14,
              width: height*0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.blue,border: Border.all(width: 6.0, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    spreadRadius: 5,
                    blurRadius:10,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ],

              ),
              child: Center(
                child: Text(username![0],
                  style: TextStyle(color: Colors.white ,fontSize: 60, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Text(username!,
              style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9).withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),// background// foreground
                    ),
                    onPressed: () {
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/images/fav_logo.png', height: 25,),
                        SizedBox(width: 12,),
                        Text("Préférences musicales",
                          style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.3),),
                      ],
                    )
                ),),
            ),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9).withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),// background// foreground
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> DisplayInfoWidget()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.remove_red_eye, color: Colors.white,size: 30,),
                        SizedBox(width: 12,),
                        Text("Aperçu de mon profil",
                          style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.3),),
                      ],
                    )
                ),),
            ),
            Container(
              height: height*0.27,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_tethering, color: Colors.white, size: 35,),
                      SizedBox(width: 10,),
                      Text("En cours d'écoute...",
                        style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    height: height*0.14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFFD9D9D9).withOpacity(0.08),
                    ),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FadeInImage.assetNetwork(
                                height: 90,
                                width: 90,
                                placeholder: "assets/images/loadingPlaceholder.gif", image: 'https://images.genius.com/ef4849be3da5fdb22ea9e656679be3a3.600x600x1.jpg'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(12, 20, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BAMBINA', style: TextStyle(fontSize:18, fontWeight: FontWeight.w500, color: Colors.white),),
                              Text('PNL', style: TextStyle(fontSize:16, fontWeight: FontWeight.w400, color: Colors.grey),),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              margin: EdgeInsets.fromLTRB(30, 0, 30,0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD9D9D9).withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),// background// foreground
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> SettingsWidget())).then((value) => setState(() {
                        username = MyApp().controller.currentUser.usernameDafl!;
                      }));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.settings, color: Colors.white,size: 30,),
                        SizedBox(width: 12,),
                        Text("Paramètres",
                          style: TextStyle(color: Colors.white ,fontSize: 17, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.3),),
                      ],
                    )
                ),),
            ),
            Spacer(),
          ],
        ),
      ),
    );

  }
}

