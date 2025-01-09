import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoreservice {
  //get collection
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  //get the current user Name

  Future<String> getUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get();
    if (docSnapshot.exists) {
      return docSnapshot.get('userName');
    } else {
      return 'No Name';
    }
  }

  //CREATE DATA
  Future<void> addNote(String note, String userName) {
    return notes.add({
      'note': note,
      'timeStamp': Timestamp.now(),
      'userName': userName,
    });
  }

  //READ DATA

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timeStamp', descending: true).snapshots();

    return notesStream;
  }

  //UPDATE

  Future<void> updateData(String docID, String newNote, String userName) {
    return notes.doc(docID).update({
      'note': newNote,
      'timeStamp': Timestamp.now(),
      'userName': 'Edit/ $userName',
    });
  }

  //DELETE

  Future<void> deleteData(String docID) {
    return notes.doc(docID).delete();
  }
}
