class AddressModel {
  final String name;
  final String label;
  final String street;
  final String area;
  final String cityZip;
  final String state;
  final String mobile;
  final bool isDefault;

  const AddressModel({
    required this.name,
    required this.label,
    required this.street,
    required this.area,
    required this.cityZip,
    required this.state,
    required this.mobile,
    this.isDefault = false,
  });
}