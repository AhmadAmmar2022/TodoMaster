
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/test.dart';

import 'provider/themProvider.dart';
import 'widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SqlDb My_dataa = SqlDb();
  bool isVisibl = true;
  double widths = 200;

  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'DarkTheme'
        : 'LightTheme';
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("$text"),
        actions: [
          chanageThemeButtonWidget(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.all(4),
        child: Card(
          child: ListTile(
          onTap: () {
           
              My_dataa.daleteDataabase();
              Get.snackbar(
              "success",
               "The note has been successfully deleted ",
               icon: Icon(Icons.delete, color: Colors.white),
               snackPosition: SnackPosition.TOP,
               backgroundColor: Color.fromARGB(255, 253, 253, 253),
               borderRadius: 20,
               margin: EdgeInsets.all(15),
               colorText: Color.fromARGB(255, 254, 1, 1),
               duration: Duration(seconds:3),
               isDismissible: true,
               dismissDirection: DismissDirection.horizontal,
               forwardAnimationCurve: Curves.easeOutBack,
               );
                   
            
          },
            title: Text(
              "  delete All notes  ",
             
            ),
          ),
        ),
      ),
    );
  }

  // showSnackBar(
  //   context,
  // ) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     backgroundColor: Colors.blue,
  //     duration: Duration(
  //       milliseconds: 1000,
  //     ),
  //     content: Text(
  //       "Notes deleted",
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   ));
  // }
}
