import 'package:expense_tracker/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/logic/expense_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExpenseCubit>()..loadExpenses(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              const Center(child: Text(' Dashboard Screen')),
              DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.25,
                maxChildSize: 0.9,
                builder: (
                  BuildContext context,
                  ScrollController scrollController,
                ) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 5,
                      itemBuilder:
                          (context, index) =>
                              ListTile(title: Text(" Item $index")),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
