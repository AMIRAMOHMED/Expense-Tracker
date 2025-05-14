import 'package:flutter/material.dart';

class CategoryModel {
  final int id;
  final String name;
  final IconData icon;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  static List<CategoryModel> categories = [
    CategoryModel(id: 1, name: 'Food', icon: Icons.fastfood),
    CategoryModel(id: 2, name: 'Transport & fuel', icon: Icons.directions_car),
    CategoryModel(id: 3, name: 'Shopping', icon: Icons.shopping_cart),
    CategoryModel(id: 4, name: 'Bills', icon: Icons.receipt),
  ];
}
