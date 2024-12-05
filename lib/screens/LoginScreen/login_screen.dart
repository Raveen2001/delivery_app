import 'package:delivery_app/screens/LoginScreen/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/logo.svg",
              height: 400,
            ),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(controller.validationMsg.value,
                style: const TextStyle(color: Colors.red))),
            const SizedBox(height: 40),
            Obx(() => ElevatedButton(
                  onPressed: controller.handleLogin,
                  child: controller.loading.value
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        )
                      : const Text("Login"),
                )),
          ],
        ),
      ),
    );
  }
}
