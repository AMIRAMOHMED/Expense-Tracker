// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  amount: (json['amount'] as num).toDouble(),
  date: json['date'] as String,
  categoryId: (json['categoryId'] as num).toInt(),
);

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': instance.amount,
      'date': instance.date,
      'categoryId': instance.categoryId,
    };
