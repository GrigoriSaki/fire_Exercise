import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoreservice {
  //get collection
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  User? user = FirebaseAuth.instance.currentUser;

  //CREATE DATA
  Future<void> addNote(String note) {
    return notes.add(
        {'note': note, 'timeStamp': Timestamp.now(), 'userEmail': user!.email});
  }

  //READ DATA

  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timeStamp', descending: true).snapshots();
    return notesStream;
  }

  //UPDATE

  Future<void> updateData(String docID, String newNote) {
    return notes.doc(docID).update({
      'note': newNote,
      'timeStamp': Timestamp.now(),
      'userEmail': user!.email
    });
  }

  //DELETE

  Future<void> deleteData(String docID) {
    return notes.doc(docID).delete();
  }
}
