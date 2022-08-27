import 'package:banking_app/common/widgets/bottom_nav.dart';
import 'package:banking_app/models/transaction_model.dart';
import 'package:banking_app/screens/auth/create_account_screen.dart';
import 'package:banking_app/screens/transaction/transaction_confirm_screen.dart';
import 'package:banking_app/screens/transaction/transaction_successful_screen.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case CreateAccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateAccountScreen(),
      );
    case BottomNav.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNav(),
      );
    // Transaction Screens Start
    case TransactionConfirmScreen.routeName:
      var arguments = routeSettings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TransactionConfirmScreen(
          arguments: arguments,
        ),
      );
    case TransactionSuccessfulScreen.routeName:
      var transaction = routeSettings.arguments as Transaction;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => TransactionSuccessfulScreen(
          transaction: transaction,
        ),
      );
    // Transaction Screens End
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
