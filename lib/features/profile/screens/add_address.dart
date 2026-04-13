import 'package:flutter/material.dart';
import '../address_model.dart';

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
      cityZip:
          '${_cityController.text} - ${_pinCodeController.text}',
      state: _stateController.text,
      mobile: _mobileController.text,
    );

    widget.onSave(newAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Add delivery address",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // ===== CONTACT DETAILS =====
                  _sectionTitle("Contact Details"),
                  _card([
                    _label("Full Name"),
                    _input(_fullNameController, "Type Your Name"),

                    const SizedBox(height: 16),

                    _label("Mobile No."),
                    _input(_mobileController, "Type Your mobile no."),
                  ]),

                  // ===== ADDRESS =====
                  _sectionTitle("Address"),
                  _card([
                    _label("Pin Code"),
                    _input(_pinCodeController, "Pin Code"),

                    const SizedBox(height: 16),

                    _label("Address"),
                    _input(_addressController, "Address"),

                    const SizedBox(height: 16),

                    _label("Locality/Town"),
                    _input(_localityController, "Locality/Town"),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label("City/District"),
                              _input(_cityController, "City/District"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label("State"),
                              _input(_stateController, "State"),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    _label("Save Address As"),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _chip("Home"),
                        const SizedBox(width: 10),
                        _chip("Work"),
                      ],
                    ),
                  ]),
                ],
              ),
            ),
          ),

          // ===== BUTTON =====
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF5F5F5),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _onSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E7A5C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Save Address",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ===== UI COMPONENTS =====

  Widget _sectionTitle(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(children: children),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _input(TextEditingController c, String hint) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }

  Widget _chip(String label) {
    final isSelected = _selectedLabel == label;

    return GestureDetector(
      onTap: () => setState(() => _selectedLabel = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E7A5C) : Colors.grey,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1E7A5C) : Colors.grey,
          ),
        ),
      ),
    );
  }
}