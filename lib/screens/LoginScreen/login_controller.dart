import 'package:delivery_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var loading = false.obs;

  var validationMsg = ''.obs;

  final AuthService authService = Get.find<AuthService>();

  Future<void> handleLogin() async {
    loading.value = true;
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      validationMsg.value = 'Please enter email and password';
      return;
    }

    if (!email.isEmail) {
      validationMsg.value = 'Please enter a valid email';
      return;
    }

    final hasLoggedIn =
        await authService.signInUsingEmailAndPassword(email, password);
    loading.value = false;

    if (hasLoggedIn) Get.offAndToNamed('/');
  }
}
