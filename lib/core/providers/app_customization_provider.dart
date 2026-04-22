import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class AppCustomizationProvider with ChangeNotifier {
  String _appBarTitle = 'صندوق دعم الأسرة';
String? _logoBase64;
  String get appBarTitle => _appBarTitle;
  String? get logoBase64 => _logoBase64;

  AppCustomizationProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _appBarTitle = prefs.getString('appBarTitle') ?? 'صندوق دعم الأسرة';
    _logoBase64 = prefs.getString('logoBase64'); // [تعديل]
    notifyListeners();
  }

  Future<void> setAppBarTitle(String title) async {
    if (title.trim().isNotEmpty) {
      _appBarTitle = title.trim();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('appBarTitle', _appBarTitle);
      notifyListeners();
    }
  }

  Future<void> pickAndSetLogo() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      // [تعديل] تحويل الصورة إلى base64
      final bytes = await picked.readAsBytes();
      _logoBase64 = base64Encode(bytes);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('logoBase64', _logoBase64!);
      notifyListeners();
    }
  }

  Future<void> removeLogo() async {
    _logoBase64 = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('logoBase64'); // [تعديل]
    notifyListeners();
  }

  // [إضافة] دالة مساعدة لتحويل base64 إلى Uint8List
  Uint8List? get logoBytes {
    if (_logoBase64 == null) return null;
    return base64Decode(_logoBase64!);
  }
}