import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_exercises/firestoreService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController EditTextController = TextEditingController();
  Firestoreservice firestoreservice = Firestoreservice();

//This is ADD and UPDATE/Edit dialog:
  void showAddDialog({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.greenAccent[100],
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (docID == null) {
                      firestoreservice.addNote(textController.text);
                    } else {
                      firestoreservice.updateData(docID, textController.text);
                    }
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'A D D',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.greenAccent[400])),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.greenAccent[400],
          size: 36,
        ),
        backgroundColor: Colors.black,
      ),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Center(child: Text('Fire Notes')),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreservice.getNotesStream(),
              builder: (context, snapshot) {
                //check if the snapshot has data

                if (snapshot.hasData) {
                  List notesList = snapshot.data!.docs;

                  if (notesList.isNotEmpty) {
                    //display a list
                    return ListView.builder(
                        itemCount: notesList.length,
                        itemBuilder: (context, index) {
                          //get each individual document
                          DocumentSnapshot document = notesList[index];
                          String docID = document.id;

                          //get note for each document
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String noteText = data['note'];

                          //display as a listTile
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Card(
                              color: Colors.greenAccent[400],
                              elevation: 8,
                              child: ListTile(
                                title: Text(
                                  noteText,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      showAddDialog(docID: docID);
                                    },
                                    icon: Icon(Icons.settings)),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                        child: Container(
                            child: const Text(
                      "There are no notes..",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    )));
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return const Text(
                    "There are no notes..",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  );
                }
              })),
    );
  }
}
