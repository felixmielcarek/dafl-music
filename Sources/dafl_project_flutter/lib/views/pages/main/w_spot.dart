import 'dart:ui';
import 'package:rive/rive.dart' as riv;

import './w_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import 'package:animations/animations.dart';

class SpotsWidget extends StatefulWidget {
  const SpotsWidget({Key? key}) : super(key: key);

  @override
  State<SpotsWidget> createState() => _SpotsWidgetState();
}

class _SpotsWidgetState extends State<SpotsWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        color: const Color(0xFF141414),
        child: SizedBox(
          height: double.maxFinite,
          child: Stack(
            children: [
              Transform.scale(
                scale: 1.1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          MyApp.controller.currentUser.spots.isEmpty
                              ? "https://i.imgur.com/Uovh293.png"
                              : MyApp.controller.currentUser.spots.last.music
                                  .linkCover),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.4)),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: MyApp.controller.currentUser.spots.isEmpty
                    ? Container()
                    : OpenContainer(
                        closedColor: Colors.transparent,
                        closedElevation: 0,
                        transitionDuration: const Duration(milliseconds: 400),
                        closedBuilder: (context, openWidget) {
                          return const PreviewInfoWidget();
                        },
                        openBuilder: (context, closeWidget) {
                          return const DisplayInfoWidget();
                        },
                      ),
              ),
              const Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: riv.RiveAnimation.asset(
                      'assets/images/search_spot_animation.riv'),
                ),
              ),
              Positioned(
                top: height * 0.68,
                width: width,
                child: MyApp.controller.currentUser.spots.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              final provider = Provider.of<CardProvider>(
                                  context,
                                  listen: false);
                              provider.dislike();
                            },
                            child: Image.asset(
                              'assets/images/bouton_dislike.png',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final provider = Provider.of<CardProvider>(
                                  context,
                                  listen: false);
                              provider.discovery();
                            },
                            child: Image.asset(
                              'assets/images/bouton_discovery.png',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final provider = Provider.of<CardProvider>(
                                  context,
                                  listen: false);
                              provider.message(this.context);
                            },
                            child: Image.asset(
                              'assets/images/bouton_messages.png',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              final provider = Provider.of<CardProvider>(
                                  context,
                                  listen: false);
                              provider.like(this.context);
                            },
                            child: Image.asset(
                              'assets/images/bouton_like.png',
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
              ),
              Align(
                child: Container(
                    width: 400,
                    height: height * 0.8,
                    margin: EdgeInsets.fromLTRB(
                        width * 0.09, height / 5, width * 0.09, height / 3.7),
                    child: Container(
                      child: buildCards(),
                    )),
              ),
              IgnorePointer(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.95),
                      Colors.black.withOpacity(0.84),
                      Colors.black.withOpacity(0.66),
                      Colors.black.withOpacity(0.41),
                      Colors.black.withOpacity(0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyApp.controller.currentUser.spots.isEmpty
                          ? ''
                          : MyApp.controller.currentUser.spots.last.music.name,
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          color: Colors.white.withOpacity(1),
                          fontSize: 20,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      MyApp.controller.currentUser.spots.isEmpty
                          ? ''
                          : MyApp
                              .controller.currentUser.spots.last.music.artist,
                      style: TextStyle(
                          fontFamily: 'DMSans',
                          color: Colors.white.withOpacity(1),
                          fontSize: 17,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.spotsList;

    return Stack(
      children: urlImages
          .map((urlImage) => CardWidget(
                urlImage: urlImage.music.linkCover,
                isFront: urlImages.last == urlImage,
              ))
          .toList(),
    );
  }
}

class DisplayInfoWidget extends StatelessWidget {
  const DisplayInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232123),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("J'aime aussi..."),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
                  Text(
                    'Pour mon mariage',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Colors.white.withOpacity(1),
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E2C2E),
                      border: Border.all(
                          width: 1, color: Colors.grey.withOpacity(0.05)),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/dadju-cover-poison.png"),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(
                                  width: 0, color: Colors.grey.withOpacity(0)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                          const SizedBox(),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ma vie',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  'Dadju',
                                  style: TextStyle(
                                      fontFamily: 'DMSans',
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class PreviewInfoWidget extends StatelessWidget {
  const PreviewInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.06,
      constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
      margin: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
      decoration: BoxDecoration(
        color: const Color(0xFF24243A).withOpacity(0.40),
        border: Border.all(width: 0, color: Colors.grey.withOpacity(0)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Me découvrir...',
            style: TextStyle(
                fontFamily: 'DMSans',
                color: Colors.white.withOpacity(1),
                fontSize: 17,
                fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
