import 'package:flutter/material.dart';
import '../address_model.dart';
import '../../../core/theme/app_colors.dart';

class AddAddressScreen extends StatefulWidget {
  final void Function(AddressModel newAddress) onSave;

  const AddAddressScreen({super.key, required this.onSave});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _localityController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  String _selectedLabel = 'Home';

  void _onSave() {
    final newAddress = AddressModel(
      name: _fullNameController.text,
      label: _selectedLabel.toUpperCase(),
      street: _addressController.text,
      area: _localityController.text,
      cityZip: '${_cityController.text} - ${_pinCodeController.text}',
      state: _stateController.text,
      mobile: _mobileController.text,
    );

    widget.onSave(newAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.darkBackground
            : AppColors.lightBackground, // Menyatu dengan background body
        elevation: 0,
        centerTitle: false, // Judul rata kiri mengikuti desain gambar
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add delivery address",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Semua elemen rata kiri
                children: [
                  const SizedBox(height: 10),

                  // ===== CONTACT DETAILS =====
                  _sectionTitle("Contact Details", isDark),
                  _label("Full Name", isDark),
                  _input(_fullNameController, "Type Your Name", isDark),

                  _label("Mobile No.", isDark),
                  _input(_mobileController, "Type Your mobile no.", isDark),

                  const SizedBox(height: 16),

                  // ===== ADDRESS =====
                  _sectionTitle("Address", isDark),

                  _label("Pin Code", isDark),
                  _input(_pinCodeController, "Pin Code", isDark),

                  _label("Address", isDark),
                  _input(_addressController, "Address", isDark),

                  _label("Locality/Town", isDark),
                  _input(_localityController, "Locality/Town", isDark),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label("City/District", isDark),
                            _input(_cityController, "City/District", isDark),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label("State", isDark),
                            _input(_stateController, "State", isDark),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // (Opsional) Label Home/Work tetap saya pertahankan jika dibutuhkan
                  _label("Save Address As", isDark),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _chip("Home", isDark),
                      const SizedBox(width: 12),
                      _chip("Work", isDark),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // ===== BUTTON SAVE ADDRESS =====
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ), // Bentuk kotak dengan sudut sedikit tumpul
                  ),
                  child: const Text(
                    "Save Address",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== UI COMPONENTS =====

  Widget _sectionTitle(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _label(String text, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _input(TextEditingController c, String hint, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        bottom: 20,
      ), // Memberi jarak antara input dan label berikutnya
      decoration: BoxDecoration(
        // Warna isi kolom input (Lebih terang sedikit dari background utama)
        color: isDark ? const Color(0xFF1C1E2D) : const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        controller: c,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: isDark ? Colors.white38 : Colors.black38,
            fontSize: 14,
          ),
          border: InputBorder.none, // Menghilangkan garis tepi (border)
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, bool isDark) {
    final isSelected = _selectedLabel == label;

    return GestureDetector(
      onTap: () => setState(() => _selectedLabel = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? Colors.white24 : Colors.grey.shade300),
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColors.primary
                : (isDark ? Colors.white70 : Colors.black54),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
