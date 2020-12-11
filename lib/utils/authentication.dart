import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future checkUserLoggedIn() async{
  await Firebase.initializeApp();
  FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      return false;
    } else {
      return true;
    }
  });
}

Future loginUser(String email , String password) async{
  await Firebase.initializeApp();
  // FirebaseAuth auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
    );
    User user = FirebaseAuth.instance.currentUser;
    
    return user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else if(e.code == 'invalid-email') {
      return 'Invalid Email';
    } else {
      return e.code;
    }
  }
}


Future registerUser(String email,String pass) async{
  await Firebase.initializeApp();
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass
    );
    User user = userCredential.user;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    print(e);
    return e;
  }
}


