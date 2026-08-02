class AddressLocationModel {
  final int id;
  final String name;
  final int? divisionId;
  final int? districtId;
  final int? upazilaId;

  const AddressLocationModel({
    required this.id,
    required this.name,
    this.divisionId,
    this.districtId,
    this.upazilaId,
  });

  factory AddressLocationModel.fromJson(Map<String, dynamic> json) {
    return AddressLocationModel(
      id: _asInt(json['id']) ?? 0,
      name: (json['name'] ??
              json['title'] ??
              json['division_name'] ??
              json['district_name'] ??
              json['upazila_name'] ??
              json['police_station_name'] ??
              json['thana_name'] ??
              '')
          .toString(),
      divisionId: _asInt(json['division_id']),
      districtId: _asInt(json['district_id']),
      upazilaId: _asInt(json['upazila_id']),
    );
  }

  static int? _asInt(dynamic value) => value is int
      ? value
      : value == null
      ? null
      : int.tryParse(value.toString());
}
