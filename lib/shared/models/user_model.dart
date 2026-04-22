class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: json['profilePicture'],
    );
  }
}

class JoinRequestModel {
  final String id;
  final String fullName;
  final String phone;
  final String countryCode;
  final String idNumber;
  final String? maritalStatus;
  final String? educationLevel;
  final String? address;
  final String? jobStatus;
  final List<String>? attachedFiles;
  final DateTime submittedAt;
  String status; // pending, under_review, approved, rejected

  JoinRequestModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.countryCode,
    required this.idNumber,
    this.maritalStatus,
    this.educationLevel,
    this.address,
    this.jobStatus,
    this.attachedFiles,
    required this.submittedAt,
    required this.status,
  });
}

class SupportRequestModel {
  final String id;
    final String trackingNumber;   // ✅ رقم التتبع

  final String name;
  final double amount;
  final String description;
  final String type; // grant, loan
  final List<String>? attachedFiles;
  final DateTime submittedAt;
  String status;

  SupportRequestModel({
    required this.id,
        required this.trackingNumber,

    required this.name,
    required this.amount,
    required this.description,
    required this.type,
    this.attachedFiles,
    required this.submittedAt,
    required this.status,
  });
}