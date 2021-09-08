enum CloudStatusType {
  FIREBASE_ERROR,
  INTERNAL_ERROR,
  CLIENT_ERROR,
  SUCCESS
}

class CloudStatus {

  static String clientInternalErrorMessage = "An internal error occurred on the client side.";

  CloudStatusType statusType;
  String statusMessage;

  CloudStatus(this.statusType, this.statusMessage);

}