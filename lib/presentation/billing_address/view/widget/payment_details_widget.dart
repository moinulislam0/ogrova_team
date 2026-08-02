import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';

class PaymentDetailsSection extends StatefulWidget {
  final double subtotal;
  final double totalPoints;
  final double shipping;
  final double tax;
  final double discountAmount;
  final double totalAmount;
  final ValueChanged<double> onDiscountChanged;

  const PaymentDetailsSection({
    super.key,
    required this.subtotal,
    required this.totalPoints,
    required this.shipping,
    required this.tax,
    required this.discountAmount,
    required this.totalAmount,
    required this.onDiscountChanged,
  });

  @override
  State<PaymentDetailsSection> createState() => _PaymentDetailsSectionState();
}

class _PaymentDetailsSectionState extends State<PaymentDetailsSection> {
  final _couponController = TextEditingController();
  bool _isApplying = false;
  double? _discountPercent;
  String? _appliedCoupon;

  @override
  void initState() {
    super.initState();
    _couponController.addListener(_resetCouponWhenChanged);
  }

  @override
  void dispose() {
    _couponController.removeListener(_resetCouponWhenChanged);
    _couponController.dispose();
    super.dispose();
  }

  void _resetCouponWhenChanged() {
    if ((_discountPercent != null || widget.discountAmount > 0) &&
        _couponController.text.trim() != _appliedCoupon) {
      _clearAppliedCoupon();
    }
  }

  void _clearAppliedCoupon() {
    widget.onDiscountChanged(0);
    setState(() {
      _discountPercent = null;
      _appliedCoupon = null;
    });
  }

  Future<void> _applyCoupon() async {
    final coupon = _couponController.text.trim();
    if (coupon.isEmpty) {
      _showMessage('Please enter a coupon code.');
      return;
    }

    setState(() => _isApplying = true);
    try {
      final response = await ApiClient().postRequest(
        endpoints: ApiEndpoints.couponCheck,
        body: {'coupon': coupon, 'subtotal': widget.subtotal},
      );
      if (!mounted) return;

      if (response is Map && response['success'] == true) {
        final data = response['data'] ?? {};

        // এখানে পরিবর্তন: 'percent' অথবা 'percentage' দুইটাই চেক করা হয়েছে
        final String type = data['discount_type']?.toString() ?? 'fixed';
        final double discountVal =
            double.tryParse(data['discount']?.toString() ?? '0') ?? 0;

        double finalDiscount = 0;

        if (type == 'percent' || type == 'percentage') {
          // পারসেন্টেজ হলে সাবটোটাল থেকে হিসাব হবে
          finalDiscount = (widget.subtotal * discountVal) / 100;
          setState(() => _discountPercent = discountVal);
        } else {
          // ফিক্সড হলে সরাসরি ওই টাকাটা ডিসকাউন্ট হবে
          finalDiscount = discountVal;
          setState(() => _discountPercent = null);
        }

        widget.onDiscountChanged(finalDiscount);
        setState(() => _appliedCoupon = coupon);
        _showMessage('Coupon applied successfully.', isError: false);
      } else {
        _clearAppliedCoupon();
        _showMessage(response['message']?.toString() ?? 'Invalid coupon code.');
      }
    } on DioException catch (e) {
      if (mounted) {
        _clearAppliedCoupon();
        final data = e.response?.data;
        _showMessage(
          data is Map ? data['message']?.toString() ?? 'Error' : 'Error',
        );
      }
    } catch (e) {
      if (mounted) {
        _clearAppliedCoupon();
        _showMessage('Could not apply this coupon.');
      }
    } finally {
      if (mounted) setState(() => _isApplying = false);
    }
  }

  // বাকি কোড (showMessage, build, _money, _row) একই থাকবে...
  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Payment Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00A86B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _row("Subtotal", _money(widget.subtotal)),
        _row("Shipping", _money(widget.shipping), isGreen: true),
        _row(
          "Point",
          "${widget.totalPoints.toStringAsFixed(0)} Points",
          isBold: true,
        ),
        _row("Estimated Tax", _money(widget.tax)),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Have a coupon or promo code?",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.local_offer_outlined),
                        hintText: "Enter coupon code",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isApplying ? null : _applyCoupon,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isApplying
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Check",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ],
              ),
              if (widget.discountAmount > 0) ...[
                const SizedBox(height: 12),
                _row(
                  _discountPercent != null
                      ? 'Coupon Discount (${_discountPercent!.toStringAsFixed(0)}%)'
                      : 'Coupon Discount',
                  '-${_money(widget.discountAmount)}',
                  isGreen: true,
                ),
                _row(
                  'You Save',
                  _money(widget.discountAmount),
                  isGreen: true,
                  isBold: true,
                ),
                _row('Total Amount', _money(widget.totalAmount), isBold: true),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _money(double amount) => 'Tk ${amount.toStringAsFixed(2)}';

  Widget _row(
    String label,
    String value, {
    bool isGreen = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isGreen ? const Color(0xFF00A86B) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
