import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController confirmController =
      TextEditingController();

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
    Color primary = const Color(0xFF1B7F5C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),

              // LOGO
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined,
                      color: primary, size: 30),
                  const SizedBox(width: 8),
                  const Text(
                    "W3Cart",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Reset Your Password",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                "Your New Password Must Be Different Form Previously Used Password.",
                textAlign: TextAlign.center,
                style: TextStyle(color: primary),
              ),

              const SizedBox(height: 30),

              // NEW PASSWORD
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("New Password"),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: isHidden1,
                decoration: InputDecoration(
                  hintText: "Type Password Here",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHidden1
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden1 = !isHidden1;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // CONFIRM PASSWORD
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password"),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: confirmController,
                obscureText: isHidden2,
                decoration: InputDecoration(
                  hintText: "Type Password Here",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHidden2
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden2 = !isHidden2;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary),
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
                    backgroundColor: primary,
                  ),
                  onPressed: () {
                    if (passwordController.text ==
                        confirmController.text) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                            content:
                                Text("Password Updated")),
                      );
                    }
                  },
                  child: const Text("Submit"),
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.popUntil(
                      context, (route) => route.isFirst);
                },
                child: Text(
                  "Back to Login",
                  style: TextStyle(color: primary),
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