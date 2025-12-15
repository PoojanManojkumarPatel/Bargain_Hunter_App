import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebasePaths {
  static const String deals = 'deals';
  static String userDeals(String uid) => 'users/$uid/deals';
  static String dealImages(String uid, String filename) =>
      'deal-images/$uid/$filename.jpg';
}

class FirebaseService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<String> uploadDealImage(File imageFile) async {
  if (!imageFile.existsSync()) {
    throw Exception("Selected image file does not exist.");
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final filename = const Uuid().v4();
  final path = 'deal-images/$uid/$filename.jpg';

  final ref = FirebaseStorage.instance.ref().child(path);
  final uploadTask = await ref.putFile(imageFile);
  return await uploadTask.ref.getDownloadURL();
}


  Future<void> saveDeal({
    required String title,
    required String store,
    required double discountedPrice,
    double? originalPrice,
    required DateTime endDate,
    String? description,
    String? imageUrl,
  }) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    await _db.collection(FirebasePaths.deals).add({
      'title': title,
      'store': store,
      'discounted_price': discountedPrice,
      'original_price': originalPrice,
      'end_date': endDate.toIso8601String(),
      'description': description,
      'image_url': imageUrl,
      'user_id': uid,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
