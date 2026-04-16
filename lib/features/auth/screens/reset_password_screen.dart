import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isHidden1 = true;
  bool isHidden2 = true;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah perangkat sedang dalam mode gelap
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Background yang beradaptasi dengan mode
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.primary,
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "W3Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: isDark
                          ? Colors.white
                          : Colors.black, // Teks dinamis
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Text(
                "Reset Your Password",
                style: TextStyle(
                  fontSize: 24,
                  color: isDark ? Colors.white : Colors.black, // Teks dinamis
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your New Password Must Be Different From Previously Used Password.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.primary),
              ),

              const SizedBox(height: 30),

              // NEW PASSWORD
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "New Password",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: isHidden1,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ), // Warna input ketikan
                decoration: InputDecoration(
                  hintText: "Type Password Here",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? AppColors.darkInputBackground
                      : Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHidden1 ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden1 = !isHidden1;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkInputBorder
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // CONFIRM PASSWORD
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: confirmController,
                obscureText: isHidden2,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ), // Warna input ketikan
                decoration: InputDecoration(
                  hintText: "Type Password Here",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white38 : Colors.black38,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? AppColors.darkInputBackground
                      : Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHidden2 ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden2 = !isHidden2;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.darkInputBorder
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),

              const Spacer(),

              // BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (passwordController.text.isEmpty ||
                        confirmController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password tidak boleh kosong"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (passwordController.text !=
                        confirmController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password tidak cocok"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Password berhasil diubah"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  "Back to Login",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
