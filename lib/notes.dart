import 'dart:collection';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/edit.dart';
import 'Done.dart';
import 'Faviority.dart';
import 'TaskDetailsPage.dart';
import 'provider/themProvider.dart';
import 'test.dart';
import 'package:provider/provider.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  SqlDb My_dataa = SqlDb();
  List responsee = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> res =
        await My_dataa.readData("SELECT * FROM 'notes' WHERE done=0");
    responsee = res.reversed.toList();
    isLoading = false;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context).pushNamed("AddNotes"),
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Text("All Tasks"),
        elevation: 5,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: responsee.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TaskDetailsPage(
                          title: responsee[index]["title"],
                          note: responsee[index]["note"],
                          date: responsee[index]["Datee"],
                          isCompleted: responsee[index]["done"] ==
                              1, // تحويل القيمة إلى Boolean
                        ),
                      ));
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        responsee[index]["title"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(responsee[index]["note"]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                                responsee[index]['Faviority'] == 1
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.redAccent),
                            onPressed: () async {
                              int newFavioritytate =
                                  responsee[index]['Faviority'] == 1 ? 0 : 1;

                              await My_dataa.updateData(
                                  "UPDATE notes SET Faviority=$newFavioritytate WHERE id=${responsee[index]['id']}");

                              setState(() {
                                responsee[index]['Faviority'] =
                                    newFavioritytate;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.done, color: Colors.green),
                            onPressed: () async {
                              await My_dataa.updateData(
                                  "UPDATE notes SET done=1 WHERE id=${responsee[index]['id']}");
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Edit(
                                    note: responsee[index]['note'],
                                    title: responsee[index]['title'],
                                    datee: responsee[index]['Datee'],
                                    id: responsee[index]['id'],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
