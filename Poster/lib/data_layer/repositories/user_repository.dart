import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poster/data_layer/repositories/shared_pref_repository.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    final user = await _firebaseAuth.currentUser();
    await _saveUserUid(user.uid);
    return user;
  }

  Future<void> signInWithCredentials(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = authResult.user;
    await _saveUserUid(user.uid);
    return user;
  }

  Future<void> signUp({String email, String password}) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = authResult.user;
    _saveUserUid(user.uid);
    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _removeUserUid(),
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future _saveUserUid(String uid) async {
    final instance = await LocalStorageRepository.getInstance();
    instance.writeUid(uid);
  }

  Future _removeUserUid() async {
    final instance = await LocalStorageRepository.getInstance();
    instance.removeUid();
  }
}
