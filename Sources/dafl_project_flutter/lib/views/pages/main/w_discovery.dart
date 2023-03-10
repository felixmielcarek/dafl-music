import 'dart:collection';

import 'package:dafl_project_flutter/main.dart';
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
                            MyApp.controller
                                .setChoice(!MyApp.controller.getChoice());
                            rebuildAllChildren(context);
                            setState(() {});
                          },
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey,
                              shadowColor: Colors.black,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(24)),
                          child: MyApp.controller.getChoice()
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
              child: MyApp.controller.getDiscoveries().isEmpty
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
    late LinkedHashMap<Music, DateTime> listDiscoveries;
    if (MyApp.controller.getChoice()) {
      //TODO : implement sort by date
      listDiscoveries = LinkedHashMap();
    } else {
      //TODO : implement sort by name
      /* var sortedKeys = MyApp.controller
          .getDiscoveries()
          .values
          .toList(growable: false)
        ..sort((v1, v2) => v1.compareTo(v2));
      listDiscoveries = LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => sortedKeys[k]); */
      listDiscoveries = LinkedHashMap();
    }
    //TODO : remove next line
    listDiscoveries = MyApp.controller.getDiscoveries();
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
                  key: Key(listDiscoveries.keys.toList()[index].name),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      dev.log(listDiscoveries.keys.toList()[reversedIndex].id);
                      dev.log(
                          listDiscoveries.keys.toList()[reversedIndex].name);
                      MyApp.controller.removeFromPlaylist(
                          listDiscoveries.keys.toList()[reversedIndex].id);
                      listDiscoveries = MyApp.controller.getDiscoveries();
                      return true;
                    }
                    if (direction == DismissDirection.startToEnd) {
                      dev.log(
                          listDiscoveries.keys.toList()[reversedIndex].name);
                      dev.log('play');
                      MyApp.controller.playTrack(
                          listDiscoveries.keys.toList()[reversedIndex].id);
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
                                        .getDiscoveries()
                                        .keys
                                        .toList()[reversedIndex]
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
                                              .getDiscoveries()
                                              .keys
                                              .toList()[reversedIndex]
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
                                                .getDiscoveries()
                                                .keys
                                                .toList()[reversedIndex]
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
