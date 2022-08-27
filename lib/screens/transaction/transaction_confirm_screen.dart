import 'package:banking_app/common/widgets/custom_appbar.dart';
import 'package:banking_app/common/widgets/custom_button.dart';
import 'package:banking_app/common/widgets/custom_loader.dart';
import 'package:banking_app/common/widgets/row_data_display.dart';
import 'package:banking_app/models/transaction_model.dart';
import 'package:banking_app/models/user_model.dart';
import 'package:banking_app/screens/transaction/transaction_successful_screen.dart';
import 'package:banking_app/services/transaction_services.dart';
import 'package:banking_app/services/user_services.dart';
import 'package:flutter/material.dart';

class TransactionConfirmScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  static const String routeName = "/confirm-transaction";
  const TransactionConfirmScreen({
    Key? key,
    this.arguments,
  }) : super(key: key);

  @override
  State<TransactionConfirmScreen> createState() =>
      _TransactionConfirmScreenState();
}

class _TransactionConfirmScreenState extends State<TransactionConfirmScreen> {
  final TransactionServices transactionServices = TransactionServices();
  final UserServices userServices = UserServices();

  bool isLoading = false;

  User? user;

  Transaction? transaction;

  fetchSearchedUser() async {
    user = await userServices.fetchSearchedUser(
      context: context,
      payID: widget.arguments!['searchQuery'],
    );
    setState(() {});
  }

  void navigateToTransactionComplete() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      TransactionSuccessfulScreen.routeName,
      (route) => false,
      arguments: transaction,
    );
  }

  sendMoney() async {
    setState(() {
      isLoading = true;
    });
    transaction = await transactionServices.transferMoney(
      context: context,
      sender: widget.arguments!['myPayId'],
      receiver: user!.payID,
      amount: widget.arguments!['amount'],
    );
    navigateToTransactionComplete();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSearchedUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Confirm Transaction",
      ),
      body: user == null
          ? const CustomLoader()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RowDataDisplay(
                  heading: "Name:",
                  value: user!.name,
                ),
                RowDataDisplay(
                  heading: "PAYID:",
                  value: user!.payID,
                ),
                RowDataDisplay(
                  heading: "Amount:",
                  value: "Rs ${widget.arguments!['amount']}",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: CustomButton(
                    isLoading: isLoading,
                    text: "Confirm Pay",
                    onTap: sendMoney,
                  ),
                ),
              ],
            ),
    );
  }
}
