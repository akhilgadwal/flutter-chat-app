import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../wigets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

final auth = FirebaseAuth.instance;

void _submitData(String useremail, String username, String userpassword,
    bool isLogin, BuildContext context) async {
  UserCredential authResult;

  try {
    if (isLogin) {
      authResult = await auth.signInWithEmailAndPassword(
          email: useremail, password: userpassword);
    } else {
      authResult = await auth.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);
    }
  } on PlatformException catch (err) {
    var message = ' Check your credntails';
    if (err.message != null) {
      message = err.message.toString();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitData),
    );
  }
}
