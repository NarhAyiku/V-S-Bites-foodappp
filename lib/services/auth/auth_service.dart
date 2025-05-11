import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodappp/models/admin.dart';

class AuthServices {
  // get instance of firebase auth
  final FirebaseAuth _FirebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _FirebaseAuth.currentUser;
  }

  // sign in 
  Future<UserCredential> signInWithEmailPassword(String email, password) async{
  // try sign user in 
    try {
        UserCredential userCredential =
      await _FirebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password,
        );

        return userCredential;
  }
  // catch any errors
  on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }

  // sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async{
  // try sign user up 
    try {
        UserCredential userCredential =
      await _FirebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );

        return userCredential;
  }

  // catch any errors
  on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }

  }

  // sign out
  Future<void> signOut() async {
    return await _FirebaseAuth.signOut();
  }

  signInWithEmailAndPassword(String text, String text2) {}

  Future<void> resetPassword(String email) async {
    try {
      await _FirebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred while resetting password';
    }
  }

  // Check if user is admin
  Future<bool> isUserAdmin(String uid) async {
    try {
      DocumentSnapshot adminDoc = await _firestore
          .collection('admins')
          .doc(uid)
          .get();
      
      return adminDoc.exists && (adminDoc.data() as Map<String, dynamic>)['isAdmin'] == true;
    } catch (e) {
      return false;
    }
  }

  // Get current user admin status
  Future<bool> currentUserIsAdmin() async {
    User? user = getCurrentUser();
    if (user == null) return false;
    return await isUserAdmin(user.uid);
  }
}