import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> documentExists(DocumentReference docRef) async {

  await docRef.get().then((DocumentSnapshot snapshot) {
    return snapshot.exists;
  });

  return false;

}

DocumentReference<Map<String, dynamic>> getData(String collectionName, useruid) {
  return FirebaseFirestore.instance.collection(collectionName).doc(useruid);
}