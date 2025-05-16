import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theming/colors.dart';
import '../../../core/widgets/category_dropdown_field.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/expense_model.dart';
import '../../../domain/logic/expense_cubit.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/date_picker_text_field.dart';

class EditExpenseForm extends StatefulWidget {
  const EditExpenseForm({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  State<EditExpenseForm> createState() => _EditExpenseFormState();
}

class _EditExpenseFormState extends State<EditExpenseForm> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController dateController;
  int? categoryId;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.expense.name);
    amountController = TextEditingController(
      text: widget.expense.amount.toString(),
    );
    dateController = TextEditingController(text: widget.expense.date);
    categoryId = widget.expense.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CustomTextFormField(
              textFieldController: nameController,
              hintText: "Expense Name",
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              textFieldController: amountController,
              hintText: "Enter Expense Amount",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            CategoryDropdownField(
              categories: CategoryModel.categories,
              initialValueId: categoryId,
              onCategorySelected: (id) {
                setState(() {
                  categoryId = id;
                });
              },
            ),
            SizedBox(height: 20.h),
            DatePickerTextField(dateController: dateController),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () {
                context.read<ExpenseCubit>().updateExpense(
                  ExpenseModel(
                    id: widget.expense.id,
                    name: nameController.text,
                    amount: double.parse(amountController.text),
                    categoryId: categoryId!,
                    date: dateController.text,
                  ),
                );
              },
              text: "Update Expense",
              color: AppColors.primaryColor,
            ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
