import '../../../main.dart';
import './w_settings.dart';
import './w_spot.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as riv;

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return const MainPageProfil();
  }
}

class MainPageProfil extends StatefulWidget {
  const MainPageProfil({Key? key}) : super(key: key);

  @override
  State<MainPageProfil> createState() => _MainPageProfilState();
}

class _MainPageProfilState extends State<MainPageProfil> {
  String? username = MyApp.controller.currentUser.usernameDafl;

  @override
  initState() {
    username = MyApp.controller.currentUser.usernameDafl;
    MyApp.controller.currentUser.actualiseCurrentMusic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xFF141414),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(30, 50, 0, 0),
              child: const Text("Profil",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "DMSans")),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                height: height * 0.14,
                width: height * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  color: Colors.blue,
                  border: Border.all(width: 6.0, color: Colors.white),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 5,
                      blurRadius: 10,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ],
                ),
                child: Center(
                    child: Text(username![0],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center))),
            Text(
              username!,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD9D9D9).withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // background// foreground
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/fav_logo.png',
                          height: 25,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          "Préférences musicales",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD9D9D9).withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // background// foreground
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DisplayInfoWidget()));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          "Aperçu de mon profil",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              height: height * 0.27,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.wifi_tethering,
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "En cours d'écoute",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(1, 9, 0, 0),
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: riv.RiveAnimation.asset(
                              'assets/images/playing_animation.riv'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    height: height * 0.14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xFFD9D9D9).withOpacity(0.08),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                    height: 90,
                                    width: 90,
                                    placeholder:
                                        "assets/images/loadingPlaceholder.gif",
                                    image: MyApp.controller.currentUser
                                        .currentMusic.linkCover))),
                        Container(
                          margin: const EdgeInsets.fromLTRB(12, 20, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MyApp.controller.currentUser.currentMusic.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              Text(
                                MyApp
                                    .controller.currentUser.currentMusic.artist,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.transparent,
              ),
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD9D9D9).withOpacity(0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), // background// foreground
                    ),
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsWidget()))
                          .then((value) => setState(() {
                                username =
                                    MyApp.controller.currentUser.usernameDafl;
                              }));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Text(
                          "Paramètres",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ],
                    )),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
