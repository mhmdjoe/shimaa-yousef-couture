import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  final ValueNotifier<bool> isAdmin = ValueNotifier<bool>(false);
  late SharedPreferences _prefs;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool login(String password) {
    if (password == 'admin123') {
      isAdmin.value = true;
      return true;
    }
    return false;
  }

  void logout() {
    isAdmin.value = false;
  }

  // Cloud-enabled image getter
  String getImageUrl(String key, String defaultValue) {
    // We will use a StreamBuilder in the UI for real-time cloud updates,
    // but we can return a local cached version first.
    return _prefs.getString('img_$key') ?? defaultValue;
  }

  // Cloud-enabled image setter
  Future<void> setImageUrl(String key, String url) async {
    await _prefs.setString('img_$key', url);
    try {
      await _db.collection('website_data').doc('images').set({
        key: url,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Firestore Error: $e');
    }
  }

  String getText(String key, String defaultValue) {
    return _prefs.getString('text_$key') ?? defaultValue;
  }

  Future<void> setText(String key, String value) async {
    await _prefs.setString('text_$key', value);
    try {
      await _db.collection('website_data').doc('text').set({
        key: value,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Firestore Error: $e');
    }
  }

  String getSocialUrl(String key) {
    return _prefs.getString('social_$key') ?? 'https://www.google.com';
  }

  Future<void> setSocialUrl(String key, String url) async {
    await _prefs.setString('social_$key', url);
    try {
      await _db.collection('website_data').doc('social').set({
        key: url,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Firestore Error: $e');
    }
  }

  // Helper to sync all data from cloud to local on startup
  Future<void> syncFromCloud() async {
    try {
      final imgSnap = await _db.collection('website_data').doc('images').get();
      if (imgSnap.exists) {
        imgSnap.data()?.forEach((key, value) {
          _prefs.setString('img_$key', value.toString());
        });
      }

      final textSnap = await _db.collection('website_data').doc('text').get();
      if (textSnap.exists) {
        textSnap.data()?.forEach((key, value) {
          _prefs.setString('text_$key', value.toString());
        });
      }

      final socialSnap = await _db.collection('website_data').doc('social').get();
      if (socialSnap.exists) {
        socialSnap.data()?.forEach((key, value) {
          _prefs.setString('social_$key', value.toString());
        });
      }
    } catch (e) {
      debugPrint('Cloud Sync Error: $e');
    }
  }
}
