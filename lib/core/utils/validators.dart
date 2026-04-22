class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'البريد الإلكتروني مطلوب';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'بريد إلكتروني غير صالح';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
    if (value.length < 6) return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'الاسم مطلوب';
    if (value.trim().length < 3) return 'الاسم قصير جداً';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return 'رقم الهاتف مطلوب';
    if (value.length != 9) return 'يجب أن يتكون من 9 أرقام';
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) return 'أرقام فقط';
    return null;
  }

  static String? countryCode(String? value) {
    if (value == null || value.isEmpty) return 'مطلوب';
    if (!RegExp(r'^\+?[0-9]{1,3}$').hasMatch(value)) return 'رمز غير صحيح';
    return null;
  }

  static String? idNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'رقم الهوية مطلوب';
    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'هذا الحقل'} مطلوب';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.isEmpty) return 'المبلغ مطلوب';
    final amount = double.tryParse(value);
    if (amount == null) return 'أدخل رقماً صحيحاً';
    if (amount <= 0) return 'المبلغ يجب أن يكون أكبر من صفر';
    return null;
  }
  
  static bool isStrongPassword(String password) {
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return password.length >= 8 && hasUpperCase && hasLowerCase && hasDigits && hasSpecial;
  }

  static String? getPasswordStrengthMessage(String password) {
    if (password.length < 8) return 'كلمة المرور قصيرة (8 أحرف على الأقل)';
    if (!password.contains(RegExp(r'[A-Z]'))) return 'يجب أن تحتوي على حرف كبير';
    if (!password.contains(RegExp(r'[a-z]'))) return 'يجب أن تحتوي على حرف صغير';
    if (!password.contains(RegExp(r'[0-9]'))) return 'يجب أن تحتوي على رقم';
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'يجب أن تحتوي على رمز خاص';
    return null;
  }

}