import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final double total;

  const CategoryCard({
    super.key,
    required this.category,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      color: AppColors.whiteFF,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            category.icon,
            size: 40.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(height: 10.h),
          Text(
            category.name,
            style: TextStyles.regular.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.black00,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${total.toStringAsFixed(2)} EGP',
            style: TextStyles.regular.copyWith(
              color: AppColors.grey26,
            ),
          ),
        ],
      ),
    );
  }
}
