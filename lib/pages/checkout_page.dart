import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khao_lao/pages/payment_page.dart';
import 'package:flutter_map/flutter_map.dart'; // Use flutter_map package
import 'package:latlong2/latlong.dart'; // Required for LatLng in flutter_map

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();

  bool _isVientianeCapital = true;
  String _selectedLogistic = 'ANS';
  
  // Map variables
  MapController? mapController;
  LatLng _selectedLocation = LatLng(17.9757, 102.6331); // Default to Vientiane center
  final List<Marker> _markers = [];

  // Primary color scheme
  final Color primaryColor = const Color(0xFFFFC65C);
  final Color backgroundColor = const Color(0xFF006633);
  

  @override
  void initState() {
    super.initState();
    // Set initial marker at Vientiane center
    _updateMarker();
  }

void _updateMarker() {
  _markers.clear();
  _markers.add(
    Marker(
      point: _selectedLocation,
      width: 40,
      height: 40,
      child: Icon(
        Icons.location_pin,
        color: Colors.red,
        size: 40,
      ),
    ),
  );
}
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _villageController.dispose();
    _districtController.dispose();
    _provinceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ຊຳລະເງິນ', style: TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'ລາຍລະອຽດການຈັດສົ່ງ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ),
                ),
                const SizedBox(height: 20),

                // Personal Information Fields
                _buildSectionTitle('ຂໍ້ມູນສ່ວນຕົວ'),
                _buildTextField(
                  controller: _nameController,
                  label: 'ຊື່ ແລະ ນາມສະກຸນ',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນຊື່ ແລະ ນາມສະກຸນຂອງທ່ານ';
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  controller: _phoneController,
                  label: 'ເບີໂທລະສັບ',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ກະລຸນາປ້ອນເບີໂທລະສັບຂອງທ່ານ';
                    } else if (value.length < 8 || value.length > 12) {
                      return 'ກະລຸນາປ້ອນເບີໂທລະສັບທີ່ຖືກຕ້ອງ';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),

                // Location Selection
                _buildSectionTitle('ສະຖານທີ່ຈັດສົ່ງ'),
                _buildDeliveryLocationSelector(),

                const SizedBox(height: 30),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ດຳເນີນການຊຳລະເງິນ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: backgroundColor,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: backgroundColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: backgroundColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }

  Widget _buildDeliveryLocationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: const Text('ນະຄອນຫຼວງວຽງຈັນ'),
                value: true,
                groupValue: _isVientianeCapital,
                activeColor: backgroundColor,
                onChanged: (value) {
                  setState(() {
                    _isVientianeCapital = value!;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: const Text('ແຂວງອື່ນໆ'),
                value: false,
                groupValue: _isVientianeCapital,
                activeColor: backgroundColor,
                onChanged: (value) {
                  setState(() {
                    _isVientianeCapital = value!;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Conditional content based on location selection
        _isVientianeCapital ? _buildVientianeMapForm() : _buildProvinceForm(),
      ],
    );
  }
  

  Widget _buildVientianeMapForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ກະລຸນາເລືອກສະຖານທີ່ຈັດສົ່ງຂອງທ່ານໃນແຜນທີ່:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: _selectedLocation,
                zoom: 13.0,
                onTap: (tapPosition, latLng) {
                  setState(() {
                    _selectedLocation = latLng;
                    _updateMarker();
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'ໝາຍເຫດ: ກົດເລືອກບ່ອນທີ່ທ່ານຕ້ອງການໃນແຜນທີ່',
          style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildProvinceForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ເລືອກຜູ້ໃຫ້ບໍລິການຂົນສົ່ງ:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedLogistic,
              onChanged: (value) {
                setState(() {
                  _selectedLogistic = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: 'ANS', child: Text('ANS Logistics')),
                DropdownMenuItem(value: 'HAL', child: Text('HAL Express')),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _villageController,
          label: 'ບ້ານ',
          icon: Icons.location_city,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ກະລຸນາປ້ອນບ້ານຂອງທ່ານ';
            }
            return null;
          },
        ),
        _buildTextField(
          controller: _districtController,
          label: 'ເມືອງ',
          icon: Icons.map,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ກະລຸນາປ້ອນເມືອງຂອງທ່ານ';
            }
            return null;
          },
        ),
        _buildTextField(
          controller: _provinceController,
          label: 'ແຂວງ',
          icon: Icons.location_on,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'ກະລຸນາປ້ອນແຂວງຂອງທ່ານ';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      final deliveryDetails = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'isVientianeCapital': _isVientianeCapital,
        'location': _isVientianeCapital
            ? {
                'latitude': _selectedLocation.latitude,
                'longitude': _selectedLocation.longitude,
              }
            : {
                'address': _addressController.text,
                'village': _villageController.text,
                'district': _districtController.text,
                'province': _provinceController.text,
                'logistic': _selectedLogistic,
              }
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('ກຳລັງດຳເນີນການສັ່ງຊື້...'),
          backgroundColor: backgroundColor,
        ),
      );

      // Navigate to payment page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(deliveryDetails: deliveryDetails),
        ),
      );
    }
  }
}