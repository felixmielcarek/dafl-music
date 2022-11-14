import 'dart:math';
import 'package:flutter/material.dart';
import '../../../main.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  final String urlImage;
  final bool isFront;

  const CardWidget({
    Key? key,
    required this.urlImage,
    required this.isFront,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox.expand(
        child: widget.isFront ? buildFrontCard() : buildCard(),
      );

  Widget buildCard() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: FadeInImage.assetNetwork(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: "assets/images/loadingPlaceholder.gif",
              image: widget.urlImage),
        ),
      );

  Widget buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus();
    final opacity = provider.getStatusOpacity();

    switch (status) {
      case CardStatus.like:
        final child =
            buildStamp(image: 'assets/images/icon_like.png', opacity: opacity);
        return child;
      case CardStatus.disLike:
        final child = buildStamp(
            image: 'assets/images/icon_dislike.png', opacity: opacity);
        return child;
      case CardStatus.discovery:
        final child = buildStamp(
            image: 'assets/images/icon_discovery.png', opacity: opacity);
        return child;
      case CardStatus.message:
        final child = buildStamp(
            image: 'assets/images/icon_messages.png', opacity: opacity);
        return child;
      default:
        return Container();
    }
  }

  Widget buildStamp({
    double angle = 0,
    required String image,
    required double opacity,
  }) {
    return Opacity(
      opacity: opacity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              border: Border.all(color: const Color(0xFF3F1DC3), width: 6),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Image.asset(
              image,
              width: 100,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFrontCard() => GestureDetector(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final provider = Provider.of<CardProvider>(context);
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 400;

            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);

            return AnimatedContainer(
              curve: Curves.easeOut,
              duration: Duration(milliseconds: milliseconds),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(
                children: [
                  buildCard(),
                  buildStamps(),
                ],
              ),
            );
          },
        ),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);

          provider.endPosition(context);
        },
      );
}
