import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///
  Future<UserCredential> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  ///
  Future<void> signOut() async {
    return _auth.signOut();
  }
}
