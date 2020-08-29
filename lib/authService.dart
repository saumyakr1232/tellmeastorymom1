import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Observable<User> user; //Firebase user
  PublishSubject loading = PublishSubject();

 AuthService(){
   user = Observable(_auth.authStateChanges());
 

}





  Future<User> signInWithGoogle() async {
    loading.add(true);
    try{
    // Trigger the authentication flow
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    User user = (await _auth.signInWithCredential(credential)).user;

    loading.add(false);
    print("signed in " + user.displayName);

        // Once signed in, return the UserCredential
    return user;

    }catch(e){

      print("Error occured while signinWith google ${e.toString()}");

      return null;
    }

    
  }

  void signOutGoogle(){
    _auth.signOut();
    print("sign out");
  }
}


final AuthService authService = AuthService();