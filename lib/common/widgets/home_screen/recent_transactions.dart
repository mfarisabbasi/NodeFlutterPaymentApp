import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  final double horizontalPadding;
  final double? verticalPadding;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final String payeeName;
  final String payeePayId;
  final String amount;
  const RecentTransactions(
      {Key? key,
      required this.horizontalPadding,
      this.verticalPadding,
      required this.leadingIcon,
      required this.leadingIconColor,
      required this.payeeName,
      required this.payeePayId,
      required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding ?? 0,
      ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: leadingIconColor,
          size: 35,
        ),
        title: Text(
          payeeName,
        ),
        subtitle: Text(
          payeePayId,
        ),
        trailing: Text(
          "Rs $amount",
        ),
      ),
    );
  }
}
