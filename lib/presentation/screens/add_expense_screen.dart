import 'package:expense_tracker/domain/logic/add_expense_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../data/models/category_model.dart';
import '../../data/models/expense_model.dart';
import '../widgets/category_dropdown_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/date_picker_text_field.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  int? categoryId;


  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dataController = TextEditingController(text: DateFormat('d/M/y').format(DateTime.now()),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteFF,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25.h),
                  Center(child: Text("Add Expense", style: TextStyles.title.copyWith(color: AppColors.primaryColor))),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    textFieldController: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " Please Enter Your Expense Name ";
                      }
                    },
                    hintText: "Expense Name",
                  ),
                  SizedBox(height: 20.h),

                  CustomTextFormField(
                    textFieldController: amountController,
                    hintText: "Enter Expense Amount",
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Expense Amount";
                      }
                    },

                  ),
                  SizedBox(height: 20.h),

                  CategoryDropdownField(
                    categories: CategoryModel.categories,
                    onCategorySelected: (id) {
                      setState(() {
                        categoryId = id;
                      });
                      // use id
                    },
                  ),
                  SizedBox(height: 20.h),
                  DatePickerTextField(
                    dateController: dataController,
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() && categoryId != null) {
                        debugPrint("form is valid");
                        context
                            .read<AddExpenseCubit>()
                            .addExpense(
                            ExpenseModel(
                          name: nameController.text,
                          amount: double.parse(amountController.text),
                          categoryId: categoryId!,
                          date: dataController.text,
                        ));

                      } else {
                        debugPrint("form is not valid");
                      }
                    },
                    text: "Add expense",
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
}
