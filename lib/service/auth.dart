import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ifmd_app/admin_panel.dart';
import 'package:ifmd_app/home_page.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Mevcut kullanıcıyı döner
  User? get getCurrentUser => _firebaseAuth.currentUser;

  // Mevcut kullanıcının e-posta adresini döner
  String? get userEmail => _firebaseAuth.currentUser?.email;
  String? get userName => _firebaseAuth.currentUser?.displayName;

  // Auth durumu değişikliklerini dinleyen bir Stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Yeni kullanıcı oluşturma
  Future<void> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Kullanıcı adı güncellemesi
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();

      // Firestore'a kullanıcı ekleme
      await firestore.collection("Users").doc(userCredential.user!.uid).set({
        "email": email,
        "name": name,
        "role": "user",
      });
    } catch (e) {
      throw Exception('Kullanıcı oluşturulamadı: $e');
    }
  }

  // Kullanıcı giriş yapma
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Kullanıcının rolünü kontrol et
      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection("Users").doc(uid).get();

      if (userDoc.exists) {
        String role = userDoc.get("role");

        // Role göre yönlendirme yap
        if (role == "user") {
          // Admin sayfasına yönlendir
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const MainPage()), // AdminPage yönlendirmesi
          );
        } else {
          // Normal kullanıcı sayfasına yönlendir
          print("$role");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const AdminPanel()), // MainPage yönlendirmesi
          );
        }
      } else {
        throw Exception("Kullanıcı Firestore'da bulunamadı.");
      }
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

  // Kullanıcı rolünü güncelleme
  Future<void> updateUserRole(String uid, String newRole) async {
    try {
      await firestore.collection("Users").doc(uid).update({
        "role": newRole,
      });
      print("Rol başarıyla güncellendi.");
    } catch (e) {
      throw Exception('Rol güncellenemedi: $e');
    }
  }

  // Kullanıcının rolünü al
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await firestore.collection("Users").doc(uid).get();

      if (userDoc.exists) {
        return userDoc.get("role");
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Rol alınamadı: $e');
    }
  }
}
