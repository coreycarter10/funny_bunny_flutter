import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() => runApp(FunnyBunny());

class FunnyBunny extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funny Bunny',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: HomePage(title: 'Funny Bunny'),
    );
  }
}

