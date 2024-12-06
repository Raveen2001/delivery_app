import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/user_model.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final _authService = Get.find<AuthService>();
  final _firestore = FirebaseFirestore.instance;
  final _usersCollection = 'users';

  final _user = Rxn<AppUser>();
  final loading = false.obs;

  AppUser? get user => _user.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    loading.value = true;
    try {
      _user.value = await getUserData();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<AppUser> getUserData() async {
    final user = _authService.user;
    final userDoc =
        await _firestore.collection(_usersCollection).doc(user!.uid).get();

    if (!userDoc.exists) {
      throw "User not found";
    }

    return AppUser.fromJson(userDoc.data()!);
  }
}
