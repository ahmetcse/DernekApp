import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mevcut kullanıcıyı döner
  User? get getCurrentUser => _firebaseAuth.currentUser;

  // Mevcut kullanıcının e-posta adresini döner
  String? get userEmail => _firebaseAuth.currentUser?.email;
  String? get userName => _firebaseAuth.currentUser?.displayName;

  // Auth durumu değişikliklerini dinleyen bir Stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Yeni kullanıcı oluşturma
  Future<void> createUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Kullanıcı adı güncellemesi
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload(); // Bilgileri yenile
      await _firestore.collection("Users").add({"email": email, "name": name});
    } catch (e) {
      throw Exception('Kullanıcı oluşturulamadı: $e');
    }
  }

  // Kullanıcı giriş yapma
  Future<void> signIn(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Giriş yapılamadı: $e');
    }
  }

  // Kullanıcı çıkış yapma
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Çıkış yapılamadı: $e');
    }
  }
}
