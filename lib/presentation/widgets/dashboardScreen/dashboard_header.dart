import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../core/theming/colors.dart';
import '../../../core/theming/styles.dart';
import 'add_expense_button.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            DateFormat('MMMM d, y').format(DateTime.now()),
            style: TextStyles.title.copyWith(color: AppColors.primaryColor),
          ),
        ),
        const AddExpenseButton(),
      ],
    );
  }
}
