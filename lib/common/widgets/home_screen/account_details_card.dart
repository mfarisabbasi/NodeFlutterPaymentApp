// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:banking_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDetailsCard extends StatelessWidget {
  final EdgeInsetsGeometry outerPadding;
  final double borderRadius;
  final Color color1;
  final Color color2;
  final double height;
  final double width;
  final String row1Text;
  final Color? row1TextColor;
  final double? row1TextSize;
  final IconData row1Icon;
  final Color? row1IconColor;
  final String row2Heading;

  final String row2Text;
  final Color? row2TextColor;
  final double? row2TextSize;
  final IconData? row2Icon;
  final String row3Text;
  final Color? row3TextColor;
  final double? row3TextSize;
  final IconData row3Icon;
  final Color? row3IconColor;
  final String row4Text;
  const AccountDetailsCard({
    Key? key,
    required this.color1,
    required this.color2,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.outerPadding,
    required this.row1Text,
    required this.row1Icon,
    required this.row2Heading,
    required this.row2Text,
    this.row2Icon,
    required this.row3Text,
    required this.row3Icon,
    required this.row4Text,
    this.row1TextColor,
    this.row1TextSize,
    this.row1IconColor,
    this.row2TextColor,
    this.row2TextSize,
    this.row3TextColor,
    this.row3TextSize,
    this.row3IconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: true).user;
    return Padding(
      padding: outerPadding,
      child: Container(
        decoration: BoxDecoration(
          // color: GlobalVariables.secondaryColor,
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
          ),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        height: height,
        width: width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      color: row1TextColor ?? Colors.white,
                      fontSize: row1TextSize ?? 20,
                    ),
                  ),
                  Icon(
                    row1Icon,
                    color: row1IconColor ?? Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$row2Heading: Rs ${user.userBalance}",
                    style: TextStyle(
                      color: row2TextColor ?? Colors.white,
                      fontSize: row2TextSize ?? 20,
                    ),
                  ),
                  Icon(
                    row2Icon,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.payID,
                    style: TextStyle(
                      color: row3TextColor ?? Colors.white,
                      fontSize: row3TextSize ?? 20,
                    ),
                  ),
                  Icon(
                    row3Icon,
                    color: row3IconColor ?? Colors.white,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 19,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    row4Text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
