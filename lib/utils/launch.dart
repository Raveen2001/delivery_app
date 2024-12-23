import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

void callPhoneNumber(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: "+91 $phoneNumber");

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    Get.snackbar("Error", "Could not call $phoneNumber");
  }
}
