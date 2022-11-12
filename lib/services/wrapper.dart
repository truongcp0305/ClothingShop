import 'package:account_manager/navigator/navigator_bar.dart';
import 'package:account_manager/screens/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    Stream<User?> getUser(){
     return auth.authStateChanges();
    }

    return StreamBuilder<User?>(
      stream: getUser(),
      builder: (context, AsyncSnapshot<User?>snapshot) {
        if (snapshot.hasData){
          var uid = snapshot.data?.uid;
          if(uid != null){
            return NavigatorBar();
          }else{
            return SignIn();
          }
        }else{
          return SignIn();
        }
        return SignIn();
      }
    );
  }
}
