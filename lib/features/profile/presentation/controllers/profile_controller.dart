import 'package:get/get.dart';
import '../../data/datasources/profile_local_datasource.dart';
import '../../domain/entities/user_profile_entity.dart';

class ProfileController extends GetxController {
  final ProfileLocalDatasource _datasource;

  ProfileController(this._datasource);

  final Rx<UserProfileEntity> profile = UserProfileEntity.empty().obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    profile.value = _datasource.getProfile();
  }

  Future<void> saveProfile(UserProfileEntity p) async {
    await _datasource.saveProfile(p);
    profile.value = p;
  }

  Future<void> clear() async {
    await _datasource.clear();
    profile.value = UserProfileEntity.empty();
  }
}
