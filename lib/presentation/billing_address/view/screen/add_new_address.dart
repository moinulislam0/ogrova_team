import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrova_team/data/models/address_location_model.dart';
import 'package:ogrova_team/presentation/billing_address/viewModel/address_location_provider.dart';
import 'package:ogrova_team/presentation/billing_address/viewModel/create_address_provider.dart';

class AddAddressModal extends ConsumerStatefulWidget {
  const AddAddressModal({super.key});

  @override
  ConsumerState<AddAddressModal> createState() => _AddAddressModalState();
}

class _AddAddressModalState extends ConsumerState<AddAddressModal> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String selectedLabel = 'Home';
  int? selectedDivisionId;
  int? selectedDistrictId;
  int? selectedUpazilaId;
  int? selectedPoliceStationId;
  bool isDefaultAddress = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(addressLocationProvider.notifier).loadLocations(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _postCodeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      if (selectedDivisionId == null ||
          selectedDistrictId == null ||
          selectedUpazilaId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select all required locations")),
        );
        return;
      }

      final success = await ref
          .read(createAddressProvider.notifier)
          .crateAddress(
            office: selectedLabel,
            recipientName: _nameController.text,
            phone: _phoneController.text,
            division: selectedDivisionId!,
            districtId: selectedDistrictId!,
            upazilaId: selectedUpazilaId!,
            policeStationId: selectedPoliceStationId,
            address: _addressController.text,
            postCode: _postCodeController.text,
            isDefault: isDefaultAddress,
          );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Address saved successfully!")),
        );
        Navigator.pop(context);
      } else if (mounted) {
        final error = ref.read(createAddressProvider).errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? "Failed to save address")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(addressLocationProvider);
    final createStatus = ref.watch(createAddressProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final districts = locationState.districts;
    final upazilas = locationState.upazilas;
    final policeStations = locationState.policeStations;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF00A86B),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'ADD NEW SHIPPING ADDRESS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Color(0xFF002233),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 15),
              _buildField('RECIPIENT NAME *', 'e.g. John ', _nameController),
              _buildField(
                'PHONE NUMBER *',
                'e.g. 017XXXXXXXX',
                _phoneController,
              ),
              _buildDropdown(
                label: 'DIVISION *',
                hint: locationState.isLoading
                    ? 'Loading divisions...'
                    : '-- Select Division --',
                value: selectedDivisionId,
                items: locationState.divisions,
                enabled: !locationState.isLoading,
                onChanged: (value) {
                  setState(() {
                    selectedDivisionId = value;
                    selectedDistrictId = null;
                    selectedUpazilaId = null;
                    selectedPoliceStationId = null;
                  });
                  if (value != null) {
                    ref
                        .read(addressLocationProvider.notifier)
                        .loadDistricts(value);
                  }
                },
              ),
              _buildDropdown(
                label: 'DISTRICT *',
                hint: '-- Select District --',
                value: selectedDistrictId,
                items: districts,
                enabled: selectedDivisionId != null,
                onChanged: (value) {
                  setState(() {
                    selectedDistrictId = value;
                    selectedUpazilaId = null;
                    selectedPoliceStationId = null;
                  });
                  if (value != null) {
                    ref
                        .read(addressLocationProvider.notifier)
                        .loadUpazilas(value);
                  }
                },
              ),
              _buildDropdown(
                label: 'UPAZILA *',
                hint: '-- Select Upazila --',
                value: selectedUpazilaId,
                items: upazilas,
                enabled: selectedDistrictId != null,
                onChanged: (value) {
                  setState(() {
                    selectedUpazilaId = value;
                    selectedPoliceStationId = null;
                  });
                  if (value != null) {
                    ref
                        .read(addressLocationProvider.notifier)
                        .loadPoliceStations(value);
                  }
                },
              ),
              _buildDropdown(
                label: 'POLICE STATION (OPTIONAL)',
                hint: '-- Select Police Station --',
                value: selectedPoliceStationId,
                items: policeStations,
                enabled: selectedUpazilaId != null,
                onChanged: (value) =>
                    setState(() => selectedPoliceStationId = value),
                isRequired: false,
              ),
              if (locationState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Unable to load locations: ${locationState.errorMessage}',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              _buildField(
                'POSTAL CODE (OPTIONAL)',
                'e.g. 1200',
                _postCodeController,
                isRequired: false,
              ),
              const Text(
                'ADDRESS LABEL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _labelBtn('Home'),
                  _labelBtn('Office'),
                  _labelBtn('Other'),
                ],
              ),
              const SizedBox(height: 20),
              _buildField(
                'STREET ADDRESS *',
                'House no, Road no, Village, Area details...',
                _addressController,
                maxLines: 3,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isDefaultAddress,
                    onChanged: (value) {
                      setState(() {
                        isDefaultAddress = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Set as default shipping address',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: createStatus.isloading ? null : _saveAddress,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00A86B),
                      ),
                      child: Text(
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        createStatus.isloading
                            ? 'Processing...'
                            : 'SAVE ADDRESS',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelBtn(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = selectedLabel == text;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedLabel = text),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00A86B) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            text.toUpperCase(),
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller, {
    int maxLines = 1,
    bool isRequired = true,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            maxLines: maxLines,
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: isDark ? Colors.grey[850] : const Color(0xFFF8F9FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required int? value,
    required List<AddressLocationModel> items,
    required bool enabled,
    required ValueChanged<int?> onChanged,
    bool isRequired = true,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<int>(
            value: value,
            isExpanded: true,
            dropdownColor: isDark ? Colors.grey[900] : Colors.white,
            hint: Text(
              enabled ? hint : 'Select previous location',
              style: const TextStyle(color: Colors.grey),
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item.id,
                    child: Text(
                      item.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: enabled ? onChanged : null,
            validator: (value) =>
                isRequired && value == null ? 'Selection required' : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: enabled
                  ? (isDark ? Colors.grey[850] : const Color(0xFFF8F9FA))
                  : Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
