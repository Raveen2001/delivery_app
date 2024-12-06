import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset("assets/icons/horizontal-logo.svg"),
    );
  }
}
