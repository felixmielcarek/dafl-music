
import 'package:flutter/cupertino.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class DaflCard extends StatelessWidget {
  final color;
  double taille = 0;

  DaflCard({required this.color});
  @override
  Widget build(BuildContext context) {
    return Swipable(
      onSwipeLeft: (finalposition){
        print('dislike');
      },
      onSwipeRight: (finalposition){
        print('like');
      },
      onSwipeUp: (finalposition){
        print('discovery');
      },
      child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
        image: AssetImage(
        'assets/images/pochette.png'),
    fit: BoxFit.cover,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
    ),
    height: 565,),);
  }
}
