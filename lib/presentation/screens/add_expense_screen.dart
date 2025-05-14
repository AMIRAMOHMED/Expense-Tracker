import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";

import '../../core/theming/AppAssets.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Center(child: SvgPicture.asset(AppAssets.wallet))),
    );
  }
}
