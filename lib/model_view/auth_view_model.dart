import 'package:flutter/material.dart';

import '../repo/auth_repository.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _myRepo.loginApi(data).then((value) {
      Utils().showErrorFlushBar(context, "Success", "Login Successful");
    }).onError((error, stackTrace) {
      print(error);
      Utils().showErrorFlushBar(context, "Error", error.toString());
    });
  }
}