import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  //setting up an instance of Firebase, making it final so no one can override it
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //stream
  Stream<User?> get userDetail {
    return _auth.authStateChanges();
  }

  Future addLPN(String e) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final uid = user.uid;
        bool data = await FirebaseFirestore.instance
            .collection('Car Number')
            .add({"LPN": e, "user": uid}).then((value) {
          return true;
        });
        if (data) {
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  //registering with email and pass
  Future registerWithEmailAndPass(String e, String p) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(
          email: e.trim(), password: p.trim());
      User? user = res.user;
      return user;
    } catch (err) {
      return null;
    }
  }

  //setting up sign in with email and pass
  Future signInWithEmailAndPass(String e, String p) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: e.trim(), password: p.trim());
      User? user = res.user;
      return user;
    } catch (err) {
      print("Caught an error: $err");
      return null;
    }
  }

  //Logout function
  void logOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print("Caught an error: $err");
    }
  }
}
