import 'package:banking_app/common/build_material_color.dart';
import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/common/widgets/bottom_nav.dart';

import 'package:banking_app/providers/user_provider.dart';
import 'package:banking_app/router.dart';
import 'package:banking_app/screens/auth/create_account_screen.dart';
import 'package:banking_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  final ThemeData theme = ThemeData();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banking App',
      theme: theme.copyWith(
        backgroundColor: Colors.white,
        colorScheme: theme.colorScheme.copyWith(
          primary: buildMaterialColor(
            GlobalVariables.primaryColor,
          ),
          secondary: buildMaterialColor(
            GlobalVariables.secondaryColor,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const BottomNav()
          : const CreateAccountScreen(),
    );
  }
}
