import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plarneit/Firebase/firestore-constants.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp();

}