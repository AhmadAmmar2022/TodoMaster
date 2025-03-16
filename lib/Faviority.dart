import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:todo/test.dart';

import 'TaskDetailsPage.dart';
import 'edit.dart';

class Faviority extends StatefulWidget {
  final dynamic respnse;
  const Faviority({Key? key, this.respnse}) : super(key: key);

  @override
  State<Faviority> createState() => _FaviorityState();
}

class _FaviorityState extends State<Faviority> {
  SqlDb My_dataa = SqlDb();
  List Faviority_list = [];

  Future readDataa() async {
    List<Map> res =
        await My_dataa.readData("SELECT * FROM 'notes' WHERE Faviority=1");
    setState(() {
      Faviority_list = res;
    });
  }

  @override
  void initState() {
    super.initState();
    readDataa();
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
        title: Text("Favorite Tasks"),
        elevation: 8,
      ),
      body: Faviority_list.isEmpty
          ? Center(child: Text("No favorite tasks yet"))
          : ListView.builder(
              itemCount: Faviority_list.length,
              itemBuilder: (context, index) {
                final task = Faviority_list[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsPage(
                          title: task['title'],
                          note: task['note'],
                          date: task['Datee'],
                          isCompleted: true,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      title: Text(
                        task["title"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text("${task['Datee']}",
                          style: TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Edit(
                                    note: task['note'],
                                    title: task['title'],
                                    datee: task['Datee'],
                                    id: task['id'],
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              int respo = await My_dataa.deleteData(
                                  "DELETE FROM notes WHERE id = ${task['id']}");
                              if (respo > 0) {
                                setState(() {
                                  Faviority_list.removeAt(index);
                                });
                                Get.snackbar(
                                  "نجاح",
                                  "تم حذف الملاحظة بنجاح",
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.redAccent,
                                  borderRadius: 10,
                                  margin: EdgeInsets.all(15),
                                  colorText: Colors.white,
                                  duration: Duration(seconds: 2),
                                );
                              }
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
