import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tellmeastorymom/screens/wrapper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<MyUser> get myUser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);


  }

    MyUser _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid) : null;
  }



  Future<User> signInWithGoogle() async {

    try{
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User user = (await _auth.signInWithCredential(credential)).user;
        // Once signed in, return the UserCredential
    return user;

    }catch(e){

      print("Error occured while signinWith google ${e.toString()}");

      User user;

      return user;
    }

    
  }

  void signOutGoogle() async {
    await GoogleSignIn().signOut();
    print("sign out");
  }
}
