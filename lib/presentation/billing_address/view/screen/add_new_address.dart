import 'package:flutter/material.dart';

class AddAddressModal extends StatefulWidget {
  const AddAddressModal({super.key});

  @override
  State<AddAddressModal> createState() => _AddAddressModalState();
}

class _AddAddressModalState extends State<AddAddressModal> {
  String selectedLabel = "HOME";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.location_on_outlined, color: Color(0xFF00A86B)),
                    SizedBox(width: 8),
                    Text("ADD NEW SHIPPING ADDRESS", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002233))),
                  ],
                ),
                IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 15),
            _buildField("RECIPIENT NAME *", "e.g. John Doe"),
            _buildField("PHONE NUMBER *", "e.g. 017XXXXXXXX"),
            _buildDropdown("DIVISION *", "-- Select Division --"),
            _buildDropdown("DISTRICT *", "-- Select District --"),
            _buildDropdown("UPAZILA *", "-- Select Upazila --"),
            _buildField("POSTAL CODE (OPTIONAL)", "e.g. 1200"),
            
            const Text("ADDRESS LABEL", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const SizedBox(height: 10),
            Row(
              children: [
                _labelBtn("HOME"),
                _labelBtn("OFFICE"),
                _labelBtn("OTHER"),
              ],
            ),
            const SizedBox(height: 20),
            _buildField("STREET ADDRESS *", "House no, Road no, Village, Area details...", maxLines: 3),
            
            Row(
              children: [
                Checkbox(value: false, onChanged: (v) {}),
                const Text("Set as default shipping address", style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text("CANCEL", style: TextStyle(color: Colors.blueGrey)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00A86B), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text("SAVE ADDRESS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _labelBtn(String text) {
    bool isSelected = selectedLabel == text;
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
            border: Border.all(color: isSelected ? const Color(0xFF00A86B) : Colors.grey.shade200),
          ),
          child: Text(text, style: TextStyle(color: isSelected ? Colors.white : Colors.blueGrey, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 8),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF8F9FA),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String hint) {
    return _buildField(label, hint); // ডেমো হিসেবে টেক্সট ফিল্ড রাখা হয়েছে, এখানে DropdownButtonFormField ব্যবহার করবেন।
  }
}

