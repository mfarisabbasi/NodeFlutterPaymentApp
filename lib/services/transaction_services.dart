import 'dart:convert';

import 'package:banking_app/common/constants/error_handling.dart';
import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/common/constants/utils.dart';
import 'package:banking_app/models/transaction_model.dart';
import 'package:banking_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TransactionServices {
  Future<List<Transaction>> fetchLoggedInUserTransactions(
      BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Transaction> transactionList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/transaction/summary'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'ax-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            transactionList.add(
              Transaction.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return transactionList;
  }

  Future<Transaction> transferMoney({
    required BuildContext context,
    required String sender,
    required String receiver,
    required double amount,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Transaction? transaction;
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/transaction/newTransaction'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'ax-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'sender': sender,
          'receiver': receiver,
          'amount': amount,
        }),
      );

      // print(res.statusCode);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          transaction = Transaction.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return transaction!;
  }
}
