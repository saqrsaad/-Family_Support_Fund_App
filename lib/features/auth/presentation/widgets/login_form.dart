import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import '../../../../core/utils/validators.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
   String? _emailError;
  String? _passwordStrengthMessage;
  bool _isPasswordValid = false;

   @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmailRealTime);
    _passwordController.addListener(_validatePasswordRealTime);
  }

  
// [إضافة] التحقق من البريد أثناء الكتابة
  void _validateEmailRealTime() {
    final email = _emailController.text.trim();
    setState(() {
      if (email.isEmpty) {
        _emailError = null;
      } else {
        _emailError = Validators.email(email);
      }
    });
  }

    void _validatePasswordRealTime() {
    final password = _passwordController.text;
    setState(() {
      if (password.isEmpty) {
        _passwordStrengthMessage = null;
        _isPasswordValid = false;
      } else {
        _isPasswordValid = Validators.isStrongPassword(password);
        _passwordStrengthMessage = _isPasswordValid 
            ? null 
            : Validators.getPasswordStrengthMessage(password);
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<void> _handleEmailLogin() async {
    if (!_formKey.currentState!.validate()) return;
    // تأكد من قوة كلمة المرور
    if (!_isPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة المرور ضعيفة، يجب أن تحتوي على أحرف كبيرة وصغيرة وأرقام ورموز')),
      );
      return;
    }
    setState(() => _isLoading = true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.loginWithEmail(
      _emailController.text.trim(),
      _passwordController.text,
       );
    setState(() => _isLoading = false);
    if (success) {
      context.go(AppRouter.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تسجيل الدخول، تحقق من البيانات')),
      );
    }
  }
  
  Future<void> _handleGoogleLogin() async {
    setState(() => _isLoading = true);
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final success = await auth.loginWithGoogle();
    setState(() => _isLoading = false);
    if (success) {
      context.go(AppRouter.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تسجيل الدخول عبر Google')),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
            // [إضافة] عرض الخطأ مباشرة إذا كان موجوداً
            errorText: _emailError,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            label: 'كلمة المرور',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
              if (!_isPasswordValid) return 'كلمة مرور ضعيفة';
              return null;
            },
          ),
          // [إضافة] عرض رسالة قوة كلمة المرور
          if (_passwordStrengthMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _passwordStrengthMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
            ),
          // [إضافة] متطلبات كلمة المرور للمستخدم
          if (_passwordController.text.isNotEmpty && !_isPasswordValid)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'يجب أن تحتوي كلمة المرور على: حرف كبير، حرف صغير، رقم، ورمز خاص (مثل @#\$%)',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'تسجيل الدخول',
            onPressed: _handleEmailLogin,
            isLoading: _isLoading,
          ),
          
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('أو', style: Theme.of(context).textTheme.bodyMedium),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _isLoading ? null : _handleGoogleLogin,
            icon: Image.asset(
              'assets/images/google_logo.png', // ضع شعار Google في assets
              height: 20,
              errorBuilder: (_, _, _) => const Icon(Icons.g_mobiledata, size: 24),
            ),
            label: const Text('تسجيل الدخول عبر Google'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
            ),
          ),
        ],
      ),
    );
  }
}