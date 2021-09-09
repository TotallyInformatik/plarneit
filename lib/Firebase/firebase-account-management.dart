import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plarneit/Firebase/firebase-data-management.dart';
import 'package:plarneit/Firebase/firestore-constants.dart';
import 'package:plarneit/main.dart';
import 'package:plarneit/utils/classes/CloudStatus.dart';

// TODO: test

CloudStatus firebaseException(FirebaseAuthException e, String errorMessageBase) {
  return new ErrorCloudStatus(ErrorCloudStatusType.FIREBASE_ERROR, errorMessageBase, e.message);
}

CloudStatus internalException(e, String errorMessageBase) {
  print(e);
  return new ErrorCloudStatus(ErrorCloudStatusType.INTERNAL_ERROR, errorMessageBase, ErrorCloudStatus.clientInternalErrorMessage);
}

typedef Future<void> FirebaseAction();
Future<CloudStatus> performFirebaseAction(FirebaseAction action, String successMessage, String errorMessageBase) async {

  try {
    await action();
    return CloudStatus(
      successMessage
    );
  } on FirebaseException catch (e) {
    return firebaseException(e, errorMessageBase);
  } catch (e) {
    return internalException(e, errorMessageBase);
  }

}

Future<void> addUserDocumentsIfNeeded(User user) async {

  String taskHandlerName = PlarneitApp.jsonHandlerCollection.taskHandler.fileName;
  String noteHandlerName = PlarneitApp.jsonHandlerCollection.noteHandler.fileName;
  String longtermGoalsHandlerName = PlarneitApp.jsonHandlerCollection.longtermGoalsHandler.fileName;

  DocumentReference userDataReference = getData(FirestoreConstants.userDataCollection, user.uid);

  if (!(await documentExists(userDataReference))) {
    userDataReference.set({
      taskHandlerName: {},
      noteHandlerName: {},
      longtermGoalsHandlerName: {}
    });
  }

  String settingsHandlerName = PlarneitApp.jsonHandlerCollection.settingsHandler.fileName;
  String cloudSettingsHandlerName = PlarneitApp.jsonHandlerCollection.cloudSettingsHandler.fileName;

  DocumentReference userPreferencesDataReference = getData(FirestoreConstants.userPreferencesDataCollection, user.uid);

  if (!(await documentExists(userPreferencesDataReference))) {
    userPreferencesDataReference.set({
      settingsHandlerName: {},
      cloudSettingsHandlerName: {},
    });
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

        return new ErrorCloudStatus(
          ErrorCloudStatusType.CLIENT_ERROR,
          "Sign-in failed, please validate your email.",
          ""
        );

      } else {

        await addUserDocumentsIfNeeded(userCredential.user);

      }

    },
    "Successfully signed in user.",
    "Error during sign-in process."
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
      firebaseSignOut();

    },
    "Successfully registered new account. Please validate email in inbox to sign-in.",
    "Error during registration process"
  );

}

Future<CloudStatus> firebaseSignOut() async {

  return await performFirebaseAction(
    () async {

      await FirebaseAuth.instance.signOut();

    },
    "Successfully signed out user",
    "Error during sign-out process"
  );

}

// for people who have forgotten their password
Future<CloudStatus> resetPassword(String email) async {

  return await performFirebaseAction(
    () async {

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    },
    "Successfully sent password reset email. Please check your Inbox for further procedure.",
    "Error during password resetting process. Please try again later."
  );

}

// for people who know their password but want to change it
Future<CloudStatus> changePassword(String currentPassword, String newPassword) async {

  return await performFirebaseAction(
    () async {

      // make sure that user is authenticated and current password is correct.
      await reauthentification(currentPassword);

      // now update password if everything is fine
      await FirebaseAuth.instance.currentUser.updatePassword(newPassword);

    },
    "Password successfully updated.",
    "Error during password-changing process."
  );

}

Future<UserCredential> reauthentification(String password) {

  User currentUser = FirebaseAuth.instance.currentUser;
  EmailAuthCredential authCredential = EmailAuthProvider.credential(email: currentUser.email, password: password);

  return currentUser.reauthenticateWithCredential(authCredential);

}
