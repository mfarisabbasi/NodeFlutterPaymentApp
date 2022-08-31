import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountMenuItems extends StatelessWidget {
  final IconData icon;
  final String menuTitle;
  final VoidCallback callback;
  const AccountMenuItems(
      {Key? key,
      required this.icon,
      required this.menuTitle,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(
        icon,
      ),
      title: GestureDetector(
        onTap: callback,
        child: Text(
          menuTitle,
        ),
      ),
    );
  }
}
