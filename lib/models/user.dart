import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String? uid;
  final String? email;
  final String? name;
  final String? photoUrl;

  User({
    this.uid,
    this.email,
    this.name,
    this.photoUrl,
  });

  factory User.fromFirebase(UserCredential userCredential) {
    return User(
      uid: userCredential.user?.uid,
      email: userCredential.user?.email,
      name: userCredential.user?.displayName,
      photoUrl: userCredential.user?.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, name: $name}';
  }
}
