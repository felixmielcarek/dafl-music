import 'package:dafl_project_flutter/main.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

import '../../../model/music.dart';

class DiscoveryWidget extends StatefulWidget {
  const DiscoveryWidget({Key? key}) : super(key: key);

  @override
  State<DiscoveryWidget> createState() => _DiscoveryWidgetState();
}

class _DiscoveryWidgetState extends State<DiscoveryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF141414),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Playlist découverte',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            MyApp.controller.currentUser.sortChoise =
                                !MyApp.controller.currentUser.sortChoise;
                            rebuildAllChildren(context);
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                              shadowColor: Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(24),
                              primary: Colors.grey),
                          child: MyApp.controller.currentUser.sortChoise
                              ? Image.asset(
                                  'assets/images/date_sort_icon.png',
                                  height: 25,
                                )
                              : Image.asset(
                                  'assets/images/alpha_sort_icon.png',
                                  height: 25,
                                ),
                        ),
                      ]),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  Text(
                    'Retrouvez ici vos nouvelles découvertes.',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.4), fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
              child: MyApp.controller.currentUser.discovery.isEmpty
                  ? Center(
                      child: Image.asset(
                      'assets/images/EmptyDiscovery-Hint.png',
                      scale: 1.8,
                    ))
                  : const DiscoveryList(),
            ),
          ],
        ),
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}

class DiscoveryList extends StatefulWidget {
  const DiscoveryList({Key? key}) : super(key: key);

  @override
  State<DiscoveryList> createState() => _DiscoveryListState();
}

class _DiscoveryListState extends State<DiscoveryList> {
  late GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    refreshKey = GlobalKey<RefreshIndicatorState>();
    refreshList();
    super.initState();
  }

  refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var listDiscoveries = MyApp.controller.getDiscoveries();
    if (MyApp.controller.currentUser.sortChoise) {
      listDiscoveries.sort((a, b) {
        return a.date.compareTo(b.date);
      });
    } else {
      listDiscoveries.sort((a, b) {
        return a.name.compareTo(b.name);
      });
    }
    return RefreshIndicator(
        onRefresh: () async {
          refreshList();
          setState(() {});
        },
        key: refreshKey,
        child: ListView.builder(
            itemCount: listDiscoveries.length,
            itemBuilder: (context, index) {
              int itemCount = listDiscoveries.length;
              int reversedIndex = itemCount - 1 - index;
              return Dismissible(
                  movementDuration: const Duration(milliseconds: 400),
                  key: Key(listDiscoveries[index].name),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      print(listDiscoveries[reversedIndex].id);
                      print(listDiscoveries[reversedIndex].name);
                      MyApp.controller.removeFromPlaylist(
                          listDiscoveries[reversedIndex].id);
                      listDiscoveries = MyApp.controller.getDiscoveries();
                      return true;
                    }
                    if (direction == DismissDirection.startToEnd) {
                      print(listDiscoveries[reversedIndex].name);
                      print('play');
                      MyApp.controller
                          .playTrack(listDiscoveries[reversedIndex].id);
                      setState(() {});
                    }
                    return false;
                  },
                  background: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/play_background.png"),
                              fit: BoxFit.cover))),
                  secondaryBackground: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/delete_background.png"),
                              fit: BoxFit.cover))),
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            width: double.infinity,
                            child: Row(children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0,
                                      color: Colors.grey.withOpacity(0)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: FadeInImage.assetNetwork(
                                    placeholder:
                                        "assets/images/loadingPlaceholder.gif",
                                    image: MyApp.controller
                                        .getDiscoveries()[reversedIndex]
                                        .linkCover),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          MyApp.controller
                                              .getDiscoveries()[reversedIndex]
                                              .name,
                                          style: TextStyle(
                                              fontFamily: 'DMSans',
                                              color:
                                                  Colors.white.withOpacity(1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                            MyApp.controller
                                                .getDiscoveries()[reversedIndex]
                                                .artist,
                                            style: TextStyle(
                                                fontFamily: 'DMSans',
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400)),
                                      ]))
                            ]))
                      ])));
            }));
  }
}
