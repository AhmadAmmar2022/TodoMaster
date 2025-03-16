import 'dart:io';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/test.dart';
import 'BottomNavigationBar.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  File? _image;
  TextEditingController dateController = TextEditingController();
  SqlDb dataBase = SqlDb();
  GlobalKey<FormState> keys = GlobalKey();
  TextEditingController note = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController date = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
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
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 49, 143, 73))),
                      labelText: 'title',
                      hintText: 'Enter youre title for note',
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
                      labelText: 'note',
                      hintText: 'Enter youre  note',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 15,
                  ),

                  TextField(
                    controller: dateController,
                    readOnly: true, // لا يمكن الكتابة يدويًا
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Date',
                      hintText: 'Select a date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateController.text = formattedDate;
                        });
                      }
                    },
                  ),
                  // Center(child:_image==null ?Text(" No image selected"):Image.file(_image!), ),

                  SizedBox(
                    height: 15,
                  ),
                  // MaterialButton(
                  //   onPressed: () async {
                  //     await uploadImage(ImageSource.camera);
                  //   },
                  //   child: Text(
                  //     " Click here to select image from Gallary ",
                  //     style: TextStyle(color: Colors.blue),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      int response = await dataBase.insertData(
                          "INSERT INTO 'notes' ('note','title','Datee')  VALUES ('${note.text}','${title.text}','${formattedDate}')");

                      print(">>>>>>>>>>>>>>>>>>>>>>>>>+" + response.toString());
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => MyWidget()),
                            (route) => false);
                      }
                    },
                    child: Text(
                      'Add Note',
                      selectionColor: Colors.white,
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required VoidCallback onclicked,
  }) =>
      Container(
        width: 125,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: MaterialButton(
          onPressed: onclicked,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white),
          ),
          // style: ElevatedButton.styleFrom(
          //     shape: StadiumBorder(),
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 50,
          //       vertical: 15,
          //     ))
        ),
      );

  Future uploadImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      final tepmimage = File(image.path);
      setState(() {
        this._image = tepmimage;
      });
    } on PlatformException catch (e) {
      print("================================");
      print(e);
    }
  }
}////////////////////////////////////////
