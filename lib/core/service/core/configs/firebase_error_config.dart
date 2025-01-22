class FirebaseErrorConfig {
  // Common Firebase errors
  static const String unknownError = 'An unknown error occurred.';
  static const String initializationFailed = 'Failed to initialize Firebase.';
  static const String authInvalidCredentials = 'Invalid email or password.';
  static const String authUserNotFound = 'User not found.';
  static const String authWeakPassword = 'Password is too weak.';
  static const String firestoreDocumentNotFound = 'Document not found.';
  static const String firestoreWriteFailed = 'Failed to write data to Firestore.';

  // Common hints
  static const String unknownErrorHint = 'Please try again later.';
  static const String initializationHint =
      'Ensure Firebase is properly configured with google-services.json or GoogleService-Info.plist.';
  static const String authInvalidCredentialsHint =
      'Check if the email is valid and the password meets security requirements.';
  static const String firestoreDocumentNotFoundHint =
      'Ensure the document ID is correct and the document exists in the collection.';
  static const String firestoreWriteFailedHint =
      'Check your Firestore rules and ensure the data is correctly formatted.';
}
