import 'package:banking_app/common/widgets/custom_appbar.dart';
import 'package:banking_app/common/widgets/custom_button.dart';
import 'package:banking_app/common/widgets/custom_textfield.dart';
import 'package:banking_app/providers/user_provider.dart';
import 'package:banking_app/screens/transaction/transaction_confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _payIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<dynamic> _users = [
    'Faris',
    'Nadir',
    'Shariq',
    'Atif',
    'Faris',
    'Nadir',
    'Shariq',
    'Atif',
  ];
  void navigateToTransactionConfirmScreen(
      String query, double amount, String myPayId) {
    Navigator.pushNamed(
      context,
      TransactionConfirmScreen.routeName,
      arguments: {
        "searchQuery": query,
        "amount": amount,
        "myPayId": myPayId,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Transfer money",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Saved Contacts"),
                Text("Add New"),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: _users.length,
              scrollDirection: Axis.horizontal,
              itemExtent: 80,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {},
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/2202/2202112.png"),
                        ),
                      ),
                      Text(
                        _users[index],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text("View all"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Transfer To",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomTextField(
              controller: _payIdController,
              hintText: "Enter Valid PAYID",
              leftIcon: const Icon(
                Icons.qr_code_2_sharp,
                color: Colors.black,
                size: 26,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Amount",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CustomTextField(
              controller: _amountController,
              hintText: "Enter Amount",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5,
            ),
            child: CustomButton(
              text: "Continue",
              onTap: () {
                navigateToTransactionConfirmScreen(
                  _payIdController.text,
                  double.parse(_amountController.text),
                  user.payID,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
