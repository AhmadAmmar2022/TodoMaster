import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'BottomNavigationBar.dart';
import 'notes.dart';
import 'test.dart';
import 'provider/themProvider.dart';
import 'test.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final note;
  final title;
  final datee;
  final id;
  const Edit({Key? key, this.note, this.title, this.datee, this.id})
      : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  SqlDb dataBase = SqlDb();

  GlobalKey<FormState> keys = GlobalKey();
  TextEditingController note = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController date = new TextEditingController();
  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    date.text = widget.datee;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Form(
              child: Column(
                children: [
                  TextField(
                    controller: title,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'title',
                      hintText: 'Enter youre title',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: note,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'name note',
                      hintText: 'Enter youre  note',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: date,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'date',
                      hintText: 'Enter youre data',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: MaterialButton(
                          color: Colors.red,
                          onPressed: () async {
                            int response = await dataBase.updateData('''
                            update notes set 
                            note="${note.text}" ,
                            title="${title.text}"  ,
                             Datee="${date.text}"  
                               where id="${widget.id}"

                            ''');
                            if (response > 0) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => MyWidget()),
                                  (route) => false);
                            }
                          },
                          child: Text(
                            "Edite Note",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
