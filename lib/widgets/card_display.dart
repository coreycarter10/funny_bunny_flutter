import 'package:flutter/material.dart' hide Card;

import '../models/card.dart';
import '../data/funny_bunny_data.dart';

class CardDisplay extends StatelessWidget {
  final Card<FbCardId> card;
  final double width;
  final double height;

  const CardDisplay({
    Key key,
    @required this.card,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Border border;
    BoxFit fit = BoxFit.fill;

    if (card.id == FbCardId.back) {
      border = Border.all(width: height * .0116, color: Colors.grey);
      fit = BoxFit.contain;
    }

    final radius = height * .07;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: Colors.white,
        ),
        child: FittedBox(fit: fit, child: Image.asset(card.imagePath)),
      ),
    );
  }
}