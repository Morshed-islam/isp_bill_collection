import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<String?> loginAdmin(String email, String pass) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: pass);
    return credential.user?.uid;
  }

  static void logout(){
    _auth.signOut();
  }



}
