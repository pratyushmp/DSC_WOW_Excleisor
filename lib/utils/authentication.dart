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

Future<UserCredential> signInWithGoogle() async {
  await Firebase.initializeApp();
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}



Future<UserCredential> signInWithFacebook() async {
  // try {
    await Firebase.initializeApp();
    // Trigger the sign-in flow
    var result;
    try {
      result = await FacebookAuth.instance.login();
    }
    catch(e) {
      print('exception: $e');
    }
    if(result == null) return null;
    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(
        facebookAuthCredential);
  // }
  // on FacebookAuthException catch(e) {
  //   return null;
  //
  // }
}
