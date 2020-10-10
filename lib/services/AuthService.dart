import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {
  //setting up an instance of Firebase, making it final so no one can override it
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //stream
  Stream<FirebaseUser> get userDetail {
    return _auth.onAuthStateChanged;
  }

  Future addLPN(String e) async {
    try{
      final FirebaseUser user = await _auth.currentUser();
      final uid = user.uid;
      bool data = await Firestore.instance.collection('Car Number').add({
        "LPN": e,
        "user": uid
      }).then((value){
        print(value.documentID);
        return true;
      });
      if(data){
        return true;
      }else{
        return false;
      }
    }catch(e){
      print("Caught error during adding LPN: $e");
      return false;
    }
  }

  //registering with email and pass
  Future registerWithEmailAndPass(String e, String p) async {
    try {
      AuthResult res =
          await _auth.createUserWithEmailAndPassword(email: e.trim(), password: p.trim());
      FirebaseUser user = res.user;
      return user;
    } catch (err) {
      print("Caught an error while signing up! Error: $err");
      return null;
    }
  }

  //setting up sign in with email and pass
  Future signInWithEmailAndPass(String e, String p) async {
    try {
      AuthResult res =
          await _auth.signInWithEmailAndPassword(email: e.trim(), password: p.trim());
      FirebaseUser user = res.user;
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
