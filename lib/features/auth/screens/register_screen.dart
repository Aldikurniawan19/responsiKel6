import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'HOTDIE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Text(
                'Create your account',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Create An Account To Continue!',
                style: TextStyle(color: AppColors.primary, fontSize: 14),
              ),
              const SizedBox(height: 30),

              const CustomTextField(
                label: 'Username',
                hintText: 'Type Username Here',
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Password',
                hintText: 'Type Password Here',
                isPassword: true,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Confirm Password',
                hintText: 'Confirm Password',
                isPassword: true,
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: isChecked,
                        activeColor: AppColors.primary,
                        side: BorderSide(
                          color: isDark
                              ? AppColors.darkInputBorder
                              : AppColors.lightInputBorder,
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'I agree to all Terms, Privacy Policy and fees',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: isChecked
                      ? () {
                          print('Register button pressed!');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isChecked
                        ? AppColors.primary
                        : (isDark ? Colors.grey[800] : Colors.grey[300]),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: isChecked
                          ? Colors.white
                          : (isDark ? Colors.grey[600] : Colors.grey[700]),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ? ',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Or sign in with Divider
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark
                          ? AppColors.darkInputBorder
                          : AppColors.lightInputBorder,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Or sign in with',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.darkTextBody
                            : AppColors.lightTextBody,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: isDark
                          ? AppColors.darkInputBorder
                          : AppColors.lightInputBorder,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    child: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    isDark: isDark,
                  ),
                  const SizedBox(width: 16),
                  _buildSocialButton(
                    child: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                      size: 28,
                    ),
                    isDark: isDark,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required Widget child,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark
              ? AppColors.darkInputBackground
              : AppColors.lightInputBackground,
          border: Border.all(
            color: isDark
                ? AppColors.darkInputBorder
                : AppColors.lightInputBorder,
          ),
        ),
        child: child,
      ),
    );
  }
}
