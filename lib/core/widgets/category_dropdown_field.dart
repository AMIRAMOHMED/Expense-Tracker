import 'package:flutter/material.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';
import '../../data/models/category_model.dart';
import 'custom_text_form_field.dart';

class CategoryDropdownField extends StatefulWidget {
  final Function(int selectedId) onCategorySelected;
  final List<CategoryModel> categories;
  final int? initialValueId;
  final String? Function(CategoryModel?)? validator;

  const CategoryDropdownField({
    super.key,
    required this.onCategorySelected,
    required this.categories,
    this.validator,
    this.initialValueId,
  });

  @override
  State<CategoryDropdownField> createState() => _CategoryDropdownFieldState();
}

class _CategoryDropdownFieldState extends State<CategoryDropdownField> {
  bool _isExpanded = false;
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setInitialValue());
  }

  void _setInitialValue() {
    if (widget.initialValueId != null) {
      final initialCategory = widget.categories.firstWhere(
            (category) => category.id == widget.initialValueId,
        orElse: () => CategoryModel(id: -1, name: '', icon: Icons.error),
      );

      if (initialCategory.id != -1) {
        _textController.text = initialCategory.name;
        // Schedule the callback after the current frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.onCategorySelected(initialCategory.id);
        });
      }
    }
  }
  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectCategory(CategoryModel category) {
    setState(() {
      _textController.text = category.name;
      _isExpanded = false;
    });
    widget.onCategorySelected(category.id);
    _fieldKey.currentState?.validate();
  }



  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: FormField<CategoryModel>(
            key: _fieldKey,
            validator: widget.validator,
            builder: (fieldState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    textFieldController: _textController,
                    hintText: 'Select Category',
                    readOnly: true,
                    errorText: fieldState.errorText,
                    // validator: widget.validator,
                    suffixIcon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.greyB2,
                    ),
                    onTap: _toggleDropdown,
                  ),
                ],
              );
            },
          ),
        ),
        if (_isExpanded)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColors.whiteFF,
              border: Border.all(color: AppColors.greyB2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return ListTile(
                  onTap: () => _selectCategory(category),
                  leading: Icon(category.icon, color: AppColors.black00),
                  title: Text(category.name, style: TextStyles.small),
                );
              },
            ),
          ),
      ],
    );
  }
}
