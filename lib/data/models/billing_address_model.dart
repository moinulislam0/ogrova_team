class BillingAddressModel {
  bool? success;
  String? message;
  List<AddressData>? data;

  BillingAddressModel({this.success, this.message, this.data});

  BillingAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressData {
  int? id;
  int? userId;
  String? label;
  String? recipientName;
  String? phone;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  int? policeStationId; 
  String? address;
  String? postalCode;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  String? deliveryCharge;
  String? codCharge;
  int? estimatedDays;
  Division? division;
  District? district;
  Upazila? upazila;
  PoliceStation? policeStation; // Null? থেকে PoliceStation? এ পরিবর্তন করা হয়েছে

  AddressData({
    this.id,
    this.userId,
    this.label,
    this.recipientName,
    this.phone,
    this.divisionId,
    this.districtId,
    this.upazilaId,
    this.policeStationId,
    this.address,
    this.postalCode,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.codCharge,
    this.estimatedDays,
    this.division,
    this.district,
    this.upazila,
    this.policeStation,
  });

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    label = json['label'];
    recipientName = json['recipient_name'];
    phone = json['phone'];
    divisionId = json['division_id'];
    districtId = json['district_id'];
    upazilaId = json['upazila_id'];
 
    policeStationId = json['police_station_id'] != null 
        ? int.tryParse(json['police_station_id'].toString()) 
        : null;
    address = json['address'];
    postalCode = json['postal_code'];
    isDefault = json['is_default'] is int 
        ? (json['is_default'] == 1) 
        : json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge']?.toString();
    codCharge = json['cod_charge']?.toString();
    estimatedDays = json['estimated_days'];
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    district = json['district'] != null ? District.fromJson(json['district']) : null;
    upazila = json['upazila'] != null ? Upazila.fromJson(json['upazila']) : null;
    policeStation = json['police_station'] != null 
        ? PoliceStation.fromJson(json['police_station']) 
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['label'] = label;
    data['recipient_name'] = recipientName;
    data['phone'] = phone;
    data['division_id'] = divisionId;
    data['district_id'] = districtId;
    data['upazila_id'] = upazilaId;
    data['police_station_id'] = policeStationId;
    data['address'] = address;
    data['postal_code'] = postalCode;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delivery_charge'] = deliveryCharge;
    data['cod_charge'] = codCharge;
    data['estimated_days'] = estimatedDays;
    if (division != null) data['division'] = division!.toJson();
    if (district != null) data['district'] = district!.toJson();
    if (upazila != null) data['upazila'] = upazila!.toJson();
    if (policeStation != null) data['police_station'] = policeStation!.toJson();
    return data;
  }
}

class Division {
  int? id;
  String? name;
  String? bnName;

  Division({this.id, this.name, this.bnName});

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bnName = json['bn_name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'bn_name': bnName};
  }
}

class District {
  int? id;
  int? divisionId;
  String? name;
  String? bnName;

  District({this.id, this.divisionId, this.name, this.bnName});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    divisionId = json['division_id'];
    name = json['name'];
    bnName = json['bn_name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'division_id': divisionId, 'name': name, 'bn_name': bnName};
  }
}

class Upazila {
  int? id;
  int? districtId;
  String? name;
  String? bnName;

  Upazila({this.id, this.districtId, this.name, this.bnName});

  Upazila.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    districtId = json['district_id'];
    name = json['name'];
    bnName = json['bn_name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'district_id': districtId, 'name': name, 'bn_name': bnName};
  }
}


class PoliceStation {
  int? id;
  int? upazilaId;
  String? name;
  String? bnName;

  PoliceStation({this.id, this.upazilaId, this.name, this.bnName});

  PoliceStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    upazilaId = json['upazila_id'];
    name = json['name'];
    bnName = json['bn_name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'upazila_id': upazilaId, 'name': name, 'bn_name': bnName};
  }
}