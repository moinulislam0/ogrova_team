import 'package:ogrova_team/data/sources/remote/add_to_cart_service.dart';
import 'package:ogrova_team/data/sources/remote/create_address_api_service.dart';
import 'package:ogrova_team/data/sources/remote/payment_api_service.dart';

class PaymentMethodRepository {
  final PaymentApiService resource;
 PaymentMethodRepository({required this.resource});
  Future<bool> paymentMethod({
    required bool sameAdress,
    required bool sameInfo,
   
    required int addressId,
    required String paytmentMethod,
    required String remark,
    required String coupon,
    required String reg,
  }) async {
    return resource.paymentMethod(
     sameAdress: sameAdress,
     sameInfo:sameInfo,
     addressId: addressId,
     paytmentMethod: paytmentMethod,
     remark: remark,
     coupon: coupon,
     reg: reg
    );
  }
}
