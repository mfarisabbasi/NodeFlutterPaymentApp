import 'package:banking_app/common/constants/utils.dart';
import 'package:banking_app/common/widgets/account_screen/account_menu_items.dart';
import 'package:banking_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthService authService = AuthService();

  void logUserOut() {
    authService.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              AccountMenuItems(
                menuTitle: "Account Summary",
                callback: () {
                  showSnackBar(context, "Working");
                },
                icon: FontAwesomeIcons.chartColumn,
              ),
              const Divider(),
              AccountMenuItems(
                menuTitle: "Settings",
                callback: () {
                  showSnackBar(context, "Working");
                },
                icon: FontAwesomeIcons.gear,
              ),
              const Divider(),
              AccountMenuItems(
                menuTitle: "Logout",
                callback: logUserOut,
                icon: FontAwesomeIcons.arrowRightFromBracket,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
