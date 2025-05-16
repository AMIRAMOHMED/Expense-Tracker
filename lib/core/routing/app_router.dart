import 'package:expense_tracker/core/routing/routes.dart';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/logic/add_expense_cubit.dart';
import '../../presentation/screens/add_expense_screen.dart';
import '../../presentation/screens/edit_expense_screen.dart';
import '../di/service_locator.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case Routes.addExpenseScreen:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => getIt<AddExpenseCubit>(),
                child: const AddExpenseScreen(),
              ),
        );
      case Routes.editExpenseScreen:
        final expense = settings.arguments as ExpenseModel;
        return MaterialPageRoute(
          builder: (_) => EditExpenseScreen(expense: expense),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
