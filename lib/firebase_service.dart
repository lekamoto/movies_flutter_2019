import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movies_udemy/utils/response.dart';
import 'package:google_sign_in/google_sign_in.dart';

String firebaseUserUid;

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Response> loginGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Usuario do Firebase
    final AuthResult result = await _auth.signInWithCredential(credential);
    FirebaseUser fUser = result.user;
    print("signed in " + fUser.displayName);

    saveUser();

    // Resposta genérica
    return Response(true,msg:"Login efetuado com sucesso");
  }

  // salva o usuario na collection de usuarios logados
  static void saveUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user != null) {
      firebaseUserUid = user.uid;
      DocumentReference refUser = Firestore.instance.collection("users")
          .document(firebaseUserUid);
      refUser.setData({'nome':user.displayName,'email':user.email,'login':user.email,'urlFoto':user.photoUrl});
    }
  }

  Future<void> logout() async {
    // Deleta este user da collection

    await _auth.signOut();
    await _googleSignIn.signOut();

  }
}
