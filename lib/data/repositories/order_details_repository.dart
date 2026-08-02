import 'package:ogrova_team/data/models/oder_details_model.dart';
import 'package:ogrova_team/data/sources/remote/order_details_service.dart';

class OrderDetailsRepository {
   OrderDetailsModel? data;
   OrderDetailsService remote;
  OrderDetailsRepository({required this.remote, this.data});
  Future<OrderDetailsModel> getData() async {
    return remote.orderDetails();
  }
}
