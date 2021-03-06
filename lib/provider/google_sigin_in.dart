import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final GoogleSignIn gooolSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await gooolSignIn.signIn();
      if (googleUser == null) return;

      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      print('Что-то пошло не по плану');
    }
    notifyListeners();
  }

  Future logout() async {
    await gooolSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
