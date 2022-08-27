import 'package:banking_app/common/widgets/custom_button.dart';
import 'package:banking_app/services/auth_services.dart';
import 'package:flutter/material.dart';

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
        child: CustomButton(
          text: "Logout",
          onTap: logUserOut,
        ),
      ),
    );
  }
}
