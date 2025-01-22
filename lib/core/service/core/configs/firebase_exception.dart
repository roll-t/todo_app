import 'firebase_error_config.dart';

class FirebaseException implements Exception {
  final String message;
  final String? hint;

  FirebaseException(this.message, [this.hint]);

  @override
  String toString() {
    return 'FirebaseException: $message${hint != null ? "\nHint: $hint" : ""}';
  }
}

class FirestoreException extends FirebaseException {
  FirestoreException([String? message, String? hint])
      : super(
          message ?? FirebaseErrorConfig.firestoreWriteFailed,
          hint ?? FirebaseErrorConfig.firestoreWriteFailedHint,
        );
}

class FirebaseAuthException extends FirebaseException {
  FirebaseAuthException([String? message, String? hint])
      : super(
          message ?? FirebaseErrorConfig.authInvalidCredentials,
          hint ?? FirebaseErrorConfig.authInvalidCredentialsHint,
        );
}

class FirebaseInitializationException extends FirebaseException {
  FirebaseInitializationException([String? message, String? hint])
      : super(
          message ?? FirebaseErrorConfig.initializationFailed,
          hint ?? FirebaseErrorConfig.initializationHint,
        );
}
