import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/widgets/category_dropdown_field.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/expense_model.dart';
import '../../../domain/logic/add_expense_cubit.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';
import '../../../core/widgets/date_picker_text_field.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int? categoryId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomTextFormField(
                textFieldController: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Please Enter Your Expense Name ";
                  }
                  return null;
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
                  return null;
                },
              ),
              SizedBox(height: 20.h),

              CategoryDropdownField(
                categories: CategoryModel.categories,
                validator: (value) {
                  if (value == null) {
                    return "Please Select Category";
                  }
                  return null;
                },
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
                  if (formKey.currentState!.validate() && categoryId != null) {
                    debugPrint("form is valid");
                    context.read<AddExpenseCubit>().addExpense(
                      ExpenseModel(
                        name: nameController.text,
                        amount: double.parse(amountController.text),
                        categoryId: categoryId!,
                        date: dateController.text,
                      ),
                    );
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
