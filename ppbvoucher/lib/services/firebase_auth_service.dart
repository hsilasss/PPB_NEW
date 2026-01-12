import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user dengan email & password
  Future<UserCredential?> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      print('Creating user account for: $email');
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).timeout(const Duration(seconds: 30), onTimeout: () {
        throw Exception('Firebase Auth timeout');
      });

      print('User created: ${userCredential.user!.uid}');

      // Save user data ke Firestore
      print('Saving to Firestore...');
      
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': name,
        'phone': '',
        'dob': '',
        'createdAt': DateTime.now(),
      }).timeout(const Duration(seconds: 30), onTimeout: () {
        throw Exception('Firestore write timeout');
      });

      print('User data saved successfully');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw Exception('Auth error: ${e.message}');
    } catch (e) {
      print('Error registering user: $e');
      rethrow;
    }
  }

  // Login user dengan email & password
  Future<UserCredential?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Update user profile di Firestore
  Future<void> updateUserProfile({
    required String username,
    required String phone,
    required String dob,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'username': username,
          'phone': phone,
          'dob': dob,
        });
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  // Get user data dari Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        return doc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return null;
  }

  // Password reset
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error resetting password: $e');
    }
  }
}
