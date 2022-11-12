import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
        body: Center(
        child: GestureDetector(
          onTap: ()async{
            await FirebaseAuth.instance.currentUser?.uid;
            await FirebaseAuth.instance.signOut();
          },
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green
            ),
            child: Center(
              child: Text(
                'SIGN OUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
