import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'Done.dart';
import 'Faviority.dart';
import 'Setting.dart';
import 'notes.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final screens = [Settings(), Done(), Faviority(), Notes()];
  int currentindex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() {
                currentindex = index;
              }),
          currentIndex: currentindex,
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 18,
          fixedColor: Color.fromARGB(255, 255, 255, 255),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.insert_emoticon_outlined),
                label: 'Done',
                backgroundColor:  Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outlined),
                label: 'Faviority',
                backgroundColor:  Theme.of(context).primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor:  Theme.of(context).primaryColor),
          ]),
    );
  }
}
