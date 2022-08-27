import 'package:auto_size_text/auto_size_text.dart';
import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/common/widgets/custom_button.dart';
import 'package:banking_app/common/widgets/custom_textfield.dart';
import 'package:banking_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = '/create-account';
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  bool isCreateAccount = true;
  bool isLogin = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void createNewUser() {
    authService.signupUser(
      context: context,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,
    );
  }

  void login() {
    authService.signinUser(
      context: context,
      email: _emailController.text,
      passsword: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        width: 250,
                        child: AutoSizeText(
                          'Authorize yourself and start transferring',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.moneyBillTransfer,
                        size: 60,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      text: "Create Account",
                      onTap: () {
                        setState(() {
                          isCreateAccount = true;
                          isLogin = false;
                        });
                      },
                      width: 150,
                      color: isCreateAccount == true
                          ? GlobalVariables.greyColor
                          : GlobalVariables.primaryColor,
                    ),
                    CustomButton(
                      text: "Login",
                      onTap: () {
                        setState(() {
                          isCreateAccount = false;
                          isLogin = true;
                        });
                      },
                      width: 150,
                      color: isLogin == true
                          ? GlobalVariables.greyColor
                          : GlobalVariables.secondaryColor,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (isLogin == false)
                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Enter Name',
                          ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Enter Email',
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Enter Password',
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: isLogin == false ? 'Create Account' : 'Login',
                          onTap: () {
                            if (isLogin == false) {
                              createNewUser();
                            } else {
                              login();
                            }
                          },
                          color: GlobalVariables.secondaryColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
