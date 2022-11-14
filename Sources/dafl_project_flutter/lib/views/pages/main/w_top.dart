import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'p_main.dart';

class TopsWidget extends StatefulWidget {
  const TopsWidget({Key? key}) : super(key: key);

  @override
  State<TopsWidget> createState() => _TopsWidgetState();
}

class _TopsWidgetState extends State<TopsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF141414),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Les Tops',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  Text(
                    'Retrouvez ici les titres les plus écoutés',
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.4), fontSize: 15),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: const [
                TopWidget(),
                TopWidget(),
                TopWidget(),
                TopWidget(),
                TopWidget(),
                TopWidget(),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      width: double.infinity,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            clipBehavior: Clip.none,
            children: [
              const Positioned(
                right: 20,
                top: -15,
                child: Icon(
                  FontAwesomeIcons.champagneGlasses,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFD9D9D9).withOpacity(0.16),
                  ),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'Pour mon mariage',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage.assetNetwork(
                      height: 120,
                      width: 120,
                      placeholder: "assets/images/loadingPlaceholder.gif",
                      image:
                          'https://images.genius.com/ef4849be3da5fdb22ea9e656679be3a3.600x600x1.jpg'),
                ),
              ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(12, 5, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'BAMBINA',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          'PNL',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  GradientText(
                          '7,2%',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                          gradient: LinearGradient(colors: [
                            Colors.orange,
                            Colors.red,
                            Colors.purple,
                          ]),
                        ),
                  ],
                ),
                ],
              ),
            ],
          ),
    );
  }
}
