import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  User? getCurrentUser() => firebaseAuth.currentUser;

  // register with email and password
  Future<UserCredential> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      return Future.error("Confirm password did not match");
    }

    try {
      final UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;

      firestore
          .collection("users")
          .doc(user.uid)
          .set({'uid': user.uid, 'email': user.email});

      return userCredential;
    } catch (e) {
      return Future.error("Register error");
    }
  }

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return Future.error("Login error");
    }
  }

  Future<void> logout() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      return Future.error("Logout error");
    }
  }
}
