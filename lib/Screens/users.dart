//import 'package:facebook_login/facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
// final FacebookLogin facebookLogin = FacebookLogin();

String? name;
String? email1;
String? imageUrl;

String? name1;
String? email2;
String? imageUrl1;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn() as GoogleSignInAccount;
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(  accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,);

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user as User;


  name = user.displayName;
  email1 = user.email;
  imageUrl = user.photoURL;

  final User currentUser = _auth.currentUser as User;
  assert(user.uid == currentUser.uid);
  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  print("user sign out");
}

// Future<String> signInWithFacebook() async{
//   final FacebookLoginException facebookLoginException = await facebookLogin.login() as FacebookLoginException;
//   final FacebookAuthProvider facebookAuthProvider = await facebookLoginException.authenticate;
// }