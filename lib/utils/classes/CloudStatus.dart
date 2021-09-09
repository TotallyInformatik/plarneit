enum ErrorCloudStatusType {
  FIREBASE_ERROR,
  INTERNAL_ERROR,
  CLIENT_ERROR
}

class CloudStatus {

  String statusMessage;

  CloudStatus(this.statusMessage);

}

class ErrorCloudStatus extends CloudStatus {

  static final String clientInternalErrorMessage = "An internal error occurred on the client side.";

  ErrorCloudStatusType statusType;
  String errorMessage;

  ErrorCloudStatus(this.statusType, String statusMessage, this.errorMessage) : super(statusMessage);

}