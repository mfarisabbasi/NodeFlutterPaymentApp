import 'package:banking_app/common/constants/error_handling.dart';
import 'package:banking_app/common/constants/global.dart';
import 'package:banking_app/common/constants/utils.dart';
import 'package:banking_app/models/user_model.dart';
import 'package:banking_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserServices {
  Future<User> fetchSearchedUser({
    required BuildContext context,
    required String payID,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    User user = User(
      id: '',
      name: '',
      email: '',
      address: '',
      type: '',
      token: '',
      userBalance: 0,
      payID: '',
    );

    try {
      http.Response res = await http.get(
        Uri.parse(
          '$uri/users/$payID',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'ax-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          user = User.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return user;
  }
}
