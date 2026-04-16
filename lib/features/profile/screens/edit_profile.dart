import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _mobileController = TextEditingController(
    text: '0123456789',
  );
  final TextEditingController _fullNameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'Example@gmail.com',
  );
  final TextEditingController _locationController = TextEditingController(
    text: 'LH-12, East Wally USA',
  );

  @override
  void dispose() {
    _mobileController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : const Color(0xFFF2F2F2),

      // --- APPBAR ---
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),

      // --- BODY ---
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mobile Number Field
                  _buildLabel('Mobile Number', isDark),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _mobileController,
                    hintText: '0123456789',
                    keyboardType: TextInputType.phone,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),

                  // Full Name Field
                  _buildLabel('Full Name', isDark),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _fullNameController,
                    hintText: 'Paijo',
                    keyboardType: TextInputType.name,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  _buildLabel('Email', isDark),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Example@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 20),

                  // Location Field
                  _buildLabel('Location', isDark),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _locationController,
                    hintText: 'LH-12, East Wally USA',
                    keyboardType: TextInputType.streetAddress,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),

          // --- SAVE BUTTON ---
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSave() {
    // TODO: Implement save logic (e.g., call API / update state)
    Navigator.pop(context);
  }

  // --- HELPER: Label ---
  Widget _buildLabel(String text, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  // --- HELPER: TextField ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isDark ? Border.all(color: AppColors.darkInputBorder) : null,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: 15,
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            color: isDark ? AppColors.darkTextBody : Colors.black38,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
    );
  }
}
