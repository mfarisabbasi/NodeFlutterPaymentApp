import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/common/widgets/custom_appbar.dart';
import 'package:banking_app/common/widgets/custom_heading.dart';
import 'package:banking_app/common/widgets/custom_loader.dart';

import 'package:banking_app/common/widgets/home_screen/account_details_card.dart';
import 'package:banking_app/common/widgets/home_screen/recent_transactions.dart';
import 'package:banking_app/models/transaction_model.dart';

import 'package:banking_app/providers/user_provider.dart';
import 'package:banking_app/services/auth_services.dart';
import 'package:banking_app/services/transaction_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction>? transactions;
  final AuthService authService = AuthService();
  final TransactionServices transactionServices = TransactionServices();

  fetchmyTransactions() async {
    transactions =
        await transactionServices.fetchLoggedInUserTransactions(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchmyTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Welcome ${user.name}",
      ),
      body: transactions == null
          ? const CustomLoader()
          : Column(
              children: [
                const AccountDetailsCard(
                  outerPadding: EdgeInsets.all(10),
                  color1: GlobalVariables.primaryColor,
                  color2: GlobalVariables.secondaryColor,
                  borderRadius: 20,
                  height: 250,
                  width: double.infinity,
                  row1Text: "Faris Abbasi",
                  row1Icon: Icons.verified,
                  row2Heading: "Balance",
                  row2Text: "62,000",
                  row3Text: "PAYREAL-305738289691",
                  row3Icon: Icons.copy_sharp,
                  row4Text: "Upgrade Account",
                ),
                const CustomHeading(
                  paddingHorizontal: 20,
                  paddingVertical: 10,
                  heading: "Recent Transactions",
                  headingSize: 20,
                  headingIcon: Icons.data_exploration,
                  headingIconSize: 26,
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactions!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final transactionData = transactions![index];

                      return RecentTransactions(
                        horizontalPadding: 20,
                        leadingIcon: transactionData.sender == user.payID
                            ? Icons.arrow_circle_up_sharp
                            : Icons.arrow_circle_down_sharp,
                        leadingIconColor: transactionData.sender == user.payID
                            ? Colors.redAccent
                            : Colors.greenAccent,
                        payeeName: transactionData.sender == user.payID
                            ? transactionData.receiverName
                            : transactionData.senderName,
                        payeePayId: transactionData.sender == user.payID
                            ? transactionData.receiver
                            : transactionData.sender,
                        amount: transactionData.amount.toString(),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
