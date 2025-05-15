import 'package:expense_tracker/presentation/widgets/stat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/colors.dart';
import '../../data/models/category_model.dart';
import '../../domain/helper/expense_summary.dart';
import 'category_card.dart';

class DashboardContent extends StatelessWidget {
  final ExpenseSummary summary;

  const DashboardContent({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final categorySummaries =
        CategoryModel.categories
            .map(
              (category) => {
                'category': category,
                'total': summary.categoryTotals[category.id] ?? 0.0,
              },
            )
            .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.whiteFF,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey26.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatRow(
                  icon: Icons.calendar_month,
                  label: 'monthly',
                  amount: summary.monthlySpending,
                ),
                SizedBox(height: 12.h),
                StatRow(
                  icon: Icons.calendar_today,
                  label: 'Yearly',
                  amount: summary.yearlySpending,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          // Category Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 1.2,
              ),
              itemCount: categorySummaries.length,
              itemBuilder: (context, index) {
                final summary = categorySummaries[index];
                final category = summary['category'] as CategoryModel;
                final total = summary['total'] as double;

                return CategoryCard(category: category, total: total);
              },
            ),
          ),

        ],
      ),
    );
  }
}
