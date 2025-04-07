import 'package:day59/shared/typedef.dart';
import 'package:day59/services/networking/ApiService.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ApiService _apiService; // إضافة الحقل _apiService

  // Constructor مع التبعية
  CategoryRepository(this._apiService);

  Future<List<Map<String, dynamic>>> getCategories() async {
    final snapshot = await _firestore.collection('Categories').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
