import 'package:json_annotation/json_annotation.dart';

part 'expense_model.g.dart';

@JsonSerializable()
class ExpenseModel {
  final int? id;
  final String title;
  final double amount;
  final String date;
  final int categoryId;

  ExpenseModel({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.categoryId,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}