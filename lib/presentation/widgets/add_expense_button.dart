
import 'package:flutter/cupertino.dart';

import '../../core/routing/routes.dart';
import '../../core/theming/colors.dart';
import 'custom_button.dart';

class AddExpenseButton extends StatelessWidget {
  const AddExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomButton(
      text: 'Add Expense',
      color: AppColors.primaryColor,
      onPressed: () {
        Navigator.pushNamed(context, Routes.addExpenseScreen);
      },
    );
  }
}
