// ignore_for_file: prefer_const_constructors

import 'package:banking_app/common/constants/global.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actionWidgets;
  CustomAppBar({Key? key, required this.title, this.actionWidgets})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Text(title),
      actions: actionWidgets,
    );
  }
}
