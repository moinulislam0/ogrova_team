import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String label, name, phone, address;
  final bool isDefault, isSelected;
  final VoidCallback onTap;

  const AddressCard({
    super.key,
    required this.label,
    required this.name,
    required this.phone,
    required this.address,
    required this.isDefault,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? colors.primary : colors.outlineVariant,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colors.onSurface,
                  ),
                ),
                const Spacer(),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "DEFAULT",
                      style: TextStyle(
                        color: Color(0xFF00A86B),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? const Color(0xFF00A86B) : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  size: 16,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 5),
                Text(phone, style: TextStyle(color: colors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              address,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.delete_outline,
                color: Colors.blueGrey[200],
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
