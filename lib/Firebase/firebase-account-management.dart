import 'package:firebase_auth/firebase_auth.dart';
import 'package:plarneit/utils/classes/CloudStatus.dart';

Future<CloudStatus> signInWithEmail(String email, String password) async {

  CloudStatus status = new CloudStatus(CloudStatusType.SUCCESS, "");

  try {

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if (!userCredential.user.emailVerified) {
      await FirebaseAuth.instance.signOut();
    }

  } on FirebaseAuthException catch (e) {

    status.statusType = CloudStatusType.ERROR;
    status.statusMessage = e.message;

  } catch (e) {

    status.statusType = CloudStatusType.ERROR;
    status.statusMessage = CloudStatus.clientInternalErrorMessage;
    print(e);

  }

  return status;

}



