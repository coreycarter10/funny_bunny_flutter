import 'package:flutter/material.dart' hide Card;

import '../data/funny_bunny_data.dart';
import '../models/deck.dart';
import '../models/card.dart';
import '../widgets/card_display.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const cardsExtent = .75; // percentage width/height of cards on screen

  final deck = Deck<FbCardId>.fromQtyTable(fbDeckData);

  Card _currentCard;
  bool _showHint = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(242, 127, 34, 1),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final width = constraints.maxWidth * cardsExtent;
            final height = constraints.maxHeight * cardsExtent;
            final hintFontSize = constraints.maxHeight * 0.025;

            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: _drawCard,
                    child: CardDisplay(
                      card: cardBack,
                      width: width,
                      height: height,
                    ),
                  ),
                  if (_currentCard != null)
                    GestureDetector(
                      onTap: _discardCard,
                      child: Dismissible(
                        key: ObjectKey(_currentCard),
                        onDismissed: _discardCard,
                        child: CardDisplay(
                          card: _currentCard,
                          width: width,
                          height: height,
                        ),
                      ),
                    ),
                  if (_showHint)
                    Align(
                      alignment: Alignment(0, 0.5),
                      child: Text(
                        "Touch to draw a card",
                        style: TextStyle(fontSize: hintFontSize),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _drawCard() {
    _showHint = false;

    setState(() {
      _currentCard = deck.draw();
    });
  }

  void _discardCard([_]) {
    setState(() {
      deck.discard(_currentCard);
      _currentCard = null;
    });
  }

  void _reset() {
    setState(() {
      deck.shuffle();
      _currentCard = null;
      _showHint = true;
    });
  }
}
