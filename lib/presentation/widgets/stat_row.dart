import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final double amount;

  const StatRow({
    super.key,
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24.sp, color: AppColors.primaryColor),
        SizedBox(width: 8.w),
        Text(
          '$label: ${amount.toStringAsFixed(2)} EGP',
          style: TextStyles.title,
        ),
      ],
    );
  }
}
