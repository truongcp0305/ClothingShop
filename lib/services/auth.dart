import 'package:account_manager/models/user_from_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserFromFirebase? userFromFirebase(User? user){
    return user != null? UserFromFirebase(uid: user.uid) : null;
  }


  Future signWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return userFromFirebase(user);
      //return user?.uid;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmail(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      await FirebaseFirestore.instance.collection('users')
          .doc(user?.uid).set({ 'firstName': email});
      FirebaseFirestore.instance.collection(email);
      return userFromFirebase(user);
    }catch(e){
      return null;
    }
  }

  Future SignOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }
}

