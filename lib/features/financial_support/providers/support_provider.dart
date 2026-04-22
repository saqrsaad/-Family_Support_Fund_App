import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/models/user_model.dart';

class SupportProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
    final List<SupportRequestModel> _requests = [];
  List<SupportRequestModel> get requests => _requests;

 // توليد رقم تتبع فريد
  String _generateTrackingNumber() {
    final now = DateTime.now();
    final random = Random().nextInt(9000) + 1000;
    return 'FIN-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-$random';
  }
  Future<SupportRequestModel?> submitSupportRequest({
    required String name,
    required double amount,
    required String description,
    required String type,
    List<String>? attachedFiles,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      final request = SupportRequestModel(
        id: const Uuid().v4().substring(0, 8),
        trackingNumber: _generateTrackingNumber(),
        name: name,
        amount: amount,
        description: description,
        type: type,
        attachedFiles: attachedFiles,
        submittedAt: DateTime.now(),
        status: 'pending',
      );

_requests.insert(0, request);
      _isLoading = false;
      notifyListeners();
    _requests.insert(0, request); // [إضافة] تخزين الطلب في القائمة
    notifyListeners();
        return request;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }
    void loadRequests() {

    _requests.addAll([
      SupportRequestModel(
        id: '1',
        trackingNumber: _generateTrackingNumber(),
        name: 'أحمد محمد',
        amount: 500,
        description: 'علاج',
        type: 'منحة',
        submittedAt: DateTime.now().subtract(const Duration(days: 2)),
        status: 'pending',
      ),
      SupportRequestModel(
        id: '2',
        trackingNumber: _generateTrackingNumber(),
        name: 'فاطمة علي',
        amount: 2000,
        description: 'ترميم منزل',
        type: 'قرض',
        submittedAt: DateTime.now().subtract(const Duration(days: 5)),
        status: 'approved',
      ),
    ]);  
        notifyListeners();

    }
}