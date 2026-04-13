import 'package:flutter/material.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  // OTP BOX
  Widget buildOtpBox(int index) {
    Color primary = const Color(0xFF1B7F5C);

    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
          ),
        ),
        onChanged: (value) {
          // maju otomatis
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
          // mundur kalau dihapus
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primary = const Color(0xFF1B7F5C);

    return Scaffold(
      backgroundColor: Colors.white,
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
                  Icon(Icons.inventory_2_outlined,
                      color: primary, size: 30),
                  const SizedBox(width: 8),
                  const Text(
                    "W3Cart",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Enter Code",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                "An Authentication Code Has Sent To\n${widget.email}",
                textAlign: TextAlign.center,
                style: TextStyle(color: primary),
              ),

              const SizedBox(height: 30),

              // OTP BOX
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    List.generate(4, (i) => buildOtpBox(i)),
              ),

              const Spacer(),

              // BUTTON
              Row(
                children: [
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: primary),
                      onPressed: () =>
                          Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                        ),
                        onPressed: () {
                          String code = controllers
                              .map((c) => c.text)
                              .join();

                          if (code.length == 4) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const ResetPasswordScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Masukkan 4 digit kode")),
                            );
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                  ),
                ],
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