import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/models/user_model.dart';

class JoinRequestProvider with ChangeNotifier {
  JoinRequestModel? _currentRequest;
  bool _isLoading = false;
  String? _error;

  JoinRequestModel? get currentRequest => _currentRequest;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // توليد رقم تتبع فريد
  

  Future<bool> submitJoinRequest({
    required String fullName,
    required String phone,
    required String countryCode,
    required String idNumber,
    String? maritalStatus,
    String? educationLevel,
    String? address,
    String? jobStatus,
    List<String>? attachedFiles,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2)); // محاكاة الشبكة

      // إنشاء طلب جديد بحالة "قيد المراجعة"
      final newRequest = JoinRequestModel(
        id: const Uuid().v4().substring(0, 8), // رقم فريد مختصر
        fullName: fullName,
        phone: phone,
        countryCode: countryCode,
        idNumber: idNumber,
        maritalStatus: maritalStatus,
        educationLevel: educationLevel,
        address: address,
        jobStatus: jobStatus,
        attachedFiles: attachedFiles,
        submittedAt: DateTime.now(),
        status: 'under_review',
      );

      _currentRequest = newRequest;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
    // تنظيف النموذج (بعد النجاح)
  void clearForm() {
    _currentRequest = null;
    _error = null;
    notifyListeners();
  }


  void clearRequest() {
    _currentRequest = null;
     _error = null;
    notifyListeners();
  }
}