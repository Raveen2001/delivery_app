import 'package:delivery_app/screens/AddEditCustomerScreen/add_edit_customer_screen.dart';
import 'package:delivery_app/screens/AddEditOrderScreen/add_edit_order_screen.dart';
import 'package:delivery_app/screens/HomeScreen/home_binding.dart';
import 'package:delivery_app/screens/HomeScreen/home_screen.dart';
import 'package:delivery_app/screens/LoginScreen/login_screen.dart';
import 'package:delivery_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery A',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
        GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
        GetPage(
          name: HomeScreen.routeName,
          page: () => HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
            name: AddEditOrderScreen.routeName,
            page: () => AddEditOrderScreen()),
        GetPage(
            name: AddEditCustomerScreen.routeName,
            page: () => AddEditCustomerScreen())
      ],
    );
  }
}
