import 'package:flutter/material.dart';
import '../address_model.dart';
import 'add_address.dart';
import '../../../core/theme/app_colors.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  final List<AddressModel> _addresses = [
    AddressModel(
      name: 'Tushar',
      label: 'OFFICE',
      street: 'Mokshita dairy near bsnl circle',
      area: 'Rk puram',
      cityZip: 'Kota -324009',
      state: 'Rajasthan',
      mobile: '0123456789',
      isDefault: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,

      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkCardBackground : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Address",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== ADD BUTTON =====
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddAddressScreen(
                      onSave: (newAddress) {
                        setState(() => _addresses.add(newAddress));
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF1E7A5C),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "+ Add New Address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1E7A5C),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== DEFAULT ADDRESS TITLE =====
            const Text(
              "Default Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ===== CARD =====
            ..._addresses.map((a) => _card(a)),
          ],
        ),
      ),
    );
  }

  // ===== CARD UI =====
  Widget _card(AddressModel a) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : Colors.white,
        border: Border.all(
          color: isDark ? AppColors.darkCardBackground : Colors.white,
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  a.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                _badge(a.label),
              ],
            ),
          ),

          // BODY
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _line(a.street),
                _line(a.area),
                _line(a.cityZip),
                _line(a.state),

                const SizedBox(height: 8),

                Text(
                  "Mobile: ${a.mobile}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const Divider(height: 1),

          // FOOTER BUTTONS
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _addresses.remove(a);
                    });
                  },
                  child: const Text(
                    "Remove",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey.shade300),
              Expanded(
                child: TextButton(onPressed: () {}, child: const Text("Edit")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===== BADGE =====
  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E7A5C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }

  // ===== TEXT LINE =====
  Widget _line(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey));
  }
}
