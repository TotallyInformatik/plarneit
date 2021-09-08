import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plarneit/Firebase/firebase-data-management.dart';
import 'package:plarneit/Firebase/firestore-constants.dart';
import 'package:plarneit/utils/classes/CloudStatus.dart';

// TODO: test

CloudStatus firebaseException(FirebaseAuthException e, String errorMessageBase) {
  return new CloudStatus(CloudStatusType.FIREBASE_ERROR, "$errorMessageBase: ${e.message}");
}

CloudStatus internalException(e, String errorMessageBase) {
  print(e);
  return new CloudStatus(CloudStatusType.INTERNAL_ERROR, "$errorMessageBase: ${CloudStatus.clientInternalErrorMessage}");
}

typedef Future<CloudStatus> FirebaseAction();
Future<CloudStatus> performFirebaseAction(FirebaseAction action, String errorMessageBase) async {

  try {
    return await action();
  } on FirebaseException catch (e) {
    return firebaseException(e, errorMessageBase);
  } catch (e) {
    return internalException(e, errorMessageBase);
  }

}

Future<void> addUserDocumentsIfNeeded(User user) async {

  // TODO: implement
  DocumentReference userDataReference = getData(FirestoreConstants.userDataCollection, user.uid);

  if (!(await documentExists(userDataReference))) {
    userDataReference.set({

    });
  }

  DocumentReference userPreferencesDataReference = getData(FirestoreConstants.userPreferencesDataCollection, user.uid);

  if (!(await documentExists(userPreferencesDataReference))) {

  }

}

Future<CloudStatus> signInWithEmail(String email, String password) async {

  return await performFirebaseAction(
    () async {

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      if (!userCredential.user.emailVerified) {

        await FirebaseAuth.instance.signOut();

        return new CloudStatus(
            CloudStatusType.CLIENT_ERROR,
            "Sign-in failed, please validate your email."
        );

      } else {

        await addUserDocumentsIfNeeded(userCredential.user);

        return new CloudStatus(
            CloudStatusType.SUCCESS,
            "Successfully signed in user."
        );

      }

    },
    "Error during sign-in process"
  );

}

Future<CloudStatus> registerWithEmail(String username, String email, String password) async {

  return await performFirebaseAction(
    () async {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      userCredential.user.updateDisplayName(username);
      userCredential.user.sendEmailVerification();

      /// since user shouldn't really be signed in if email isn't verified, we have to sign them out.

      return new CloudStatus(
          CloudStatusType.SUCCESS,
          "Successfully registered new account. Please validate email in inbox to sign-in."
      );

    },
    "Error during registration process"
  );

}

Future<CloudStatus> firebaseSignOut() async {

  return await performFirebaseAction(
    () async {

      await FirebaseAuth.instance.signOut();

      return new CloudStatus(
          CloudStatusType.SUCCESS,
          "Successfully signed out user"
      );

    },
    "Error during sign-out process"
  );

}



