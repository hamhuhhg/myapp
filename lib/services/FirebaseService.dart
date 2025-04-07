import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // تسجيل مستخدم جديد
  Future<User?> registerUser({
	required String name,
	required String email,
	required String password,
  }) async {
	try {
	  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
		email: email,
		password: password,
	  );

	  // حفظ بيانات المستخدم في Firestore
	  await _firestore.collection('users').doc(userCredential.user!.uid).set({
		'name': name,
		'email': email,
		'createdAt': FieldValue.serverTimestamp(),
	  });

	  return userCredential.user;
	} catch (e) {
	  print('Error registering user: $e');
	  rethrow;
	}
  }

  // تسجيل الدخول
  Future<User?> loginUser({
	required String email,
	required String password,
  }) async {
	try {
	  UserCredential userCredential = await _auth.signInWithEmailAndPassword(
		email: email,
		password: password,
	  );
	  return userCredential.user;
	} catch (e) {
	  print('Error logging in: $e');
	  rethrow;
	}
  }

  // تسجيل الخروج
  Future<void> logoutUser() async {
	await _auth.signOut();
  }

  // استرجاع بيانات المستخدم
  Future<Map<String, dynamic>?> getUserData(String uid) async {
	try {
	  DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
	  return userDoc.data() as Map<String, dynamic>?;
	} catch (e) {
	  print('Error fetching user data: $e');
	  rethrow;
	}
  }
}