import 'package:ogrova_team/data/sources/remote/profile_upadate_service.dart';

class ProfileUpdateRepository {
  final ProfileUpdateService remote;
  ProfileUpdateRepository({required this.remote});
  Future<bool> profileUpdate({
    required String name,
    required String email,

    required String dob,
    required String phone,
    required String gender,
    required String bloodGroup,
    required String presentAddress,
    required String permanentAddress,
    required String nationalId,
    required String photo,
  }) async {
    return remote.profileUpdate(
      name: name,
      email: email,
      dob: dob,
      phone: phone,
      gender: gender,
      bloodGroup: bloodGroup,
      presentAddress: presentAddress,
      permanentAddress: permanentAddress,
      nationalId: nationalId,
      photo: photo,
    );
  }
}
