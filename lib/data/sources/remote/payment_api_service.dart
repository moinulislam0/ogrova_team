import 'package:dio/dio.dart';
import 'package:ogrova_team/core/network/api_clients.dart';
import 'package:ogrova_team/core/network/api_endpoints.dart';
import 'package:ogrova_team/presentation/billing_address/view/widget/payment_details_widget.dart';

class PaymentApiService{
  final ApiClient apiClient;
 PaymentApiService({required this.apiClient});
  Future<bool> paymentMethod({
    required bool sameAdress,
    required bool sameInfo,
   
    required int addressId,
    required String paytmentMethod,
    required String remark,
    required String coupon,
    required String reg
 
  
  
  
  }) async {
    try {
      final body = <String, dynamic>{
        "same_address": sameAdress,
  "save_info": sameInfo,
  "address_id": addressId,
  "payment_method": paytmentMethod,
  "remarks": remark,
  "coupon": coupon
      };
      
      final response = await apiClient.postRequest(
        endpoints: ApiEndpoints.payment(reg),
        body: body,
      );

      if (response is Map && response['success'] == true) {
        return true;
      }
      throw Exception(response is Map
          ? response['message']?.toString() ?? 'Failed to Proceed to payment.'
          : 'Failed to Proceed to payment.');
    } on DioException catch (e) {
      final data = e.response?.data;
      final errors = data is Map ? data['errors'] : null;
      final validationErrors = errors is Map
          ? errors.values
              .expand((value) => value is List ? value : [value])
              .map((value) => value.toString())
              .join('\n')
          : null;
      final errorMessage = validationErrors?.isNotEmpty == true
          ? validationErrors!
          : data is Map && data['message'] != null
          ? data['message'].toString()
          : 'Failed to Proceed to payment.';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
