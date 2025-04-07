import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _storage.write(key: 'user', value: userCredential.user?.uid);
      return userCredential.user;
    } catch (e) {
      print(e); // Tangani kesalahan di sini
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _storage.write(key: 'user', value: userCredential.user?.uid);
      return userCredential.user;
    } catch (e) {
      print(e); // Tangani kesalahan di sini
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _storage.delete(key: 'user');
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }
}
