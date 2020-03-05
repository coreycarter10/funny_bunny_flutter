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
  bool _showDrawHint = true;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.green[800],
            Colors.green[700],
            Colors.green[600],
            Colors.green[400],
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(242, 127, 34, 1),
                  Colors.orange[400],
                ],
              ),
            ),
          ),
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

              final hintStyle = TextStyle(
                fontSize: constraints.maxHeight * 0.025,
                fontFamily: "ComingSoon",
              );

              return SizedBox(
                width: width,
                height: height,
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (_showDrawHint) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.chevron_left),
                                Text(
                                  " Swipe or touch card to discard",
                                  style: hintStyle,
                                ),
                              ],
                            ),
                          ));
                        }

                        _showDrawHint = false;
                        setState(() {
                          _currentCard = deck.draw();
                        });
                      },
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
                    if (_showDrawHint)
                      Align(
                        alignment: Alignment(0, 0.65),
                        child: Text("Touch to draw a card", style: hintStyle),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
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
      _showDrawHint = true;
    });
  }
}
