import 'package:expense_tracker/core/theming/colors.dart';
import 'package:expense_tracker/core/theming/styles.dart';
import 'package:expense_tracker/data/models/category_model.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/domain/logic/expense_cubit.dart';
import 'package:expense_tracker/presentation/widgets/category_dropdown_field.dart';
import 'package:expense_tracker/presentation/widgets/custom_button.dart';
import 'package:expense_tracker/presentation/widgets/custom_text_form_field.dart';
import 'package:expense_tracker/presentation/widgets/date_picker_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/edit_expense_listener.dart';

class EditExpenseScreen extends StatefulWidget {
  final ExpenseModel expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
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
    return EditExpenseListener(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteFF,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Center(
                    child: Text(
                      "Edit Expense",
                      style: TextStyles.title.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
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
          ),
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
