import 'package:flutter/material.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pushNamed(context, Routes.addExpenseScreen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Add Expense",
              style: TextStyles.title.copyWith(color: AppColors.primaryColor),
            ),
            Icon(Icons.add, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
