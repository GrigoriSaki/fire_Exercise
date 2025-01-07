// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_exercises/firestoreService.dart';
import 'package:fire_exercises/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/myDrawer.dart';

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
              backgroundColor: Theme.of(context).colorScheme.surface,
              content: TextField(
                cursorColor: Theme.of(context).colorScheme.inversePrimary,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary))),
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
      drawer: MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
          size: 36,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Fire Notes',
          style: TextStyle(fontSize: 26),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
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
                              color: Theme.of(context).colorScheme.secondary,
                              elevation: 8,
                              child: ListTile(
                                title: Text(
                                  noteText,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showAddDialog(docID: docID);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 32,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          firestoreservice.deleteData(docID);
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_outlined,
                                          size: 32,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                        ))
                                  ],
                                ),
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
