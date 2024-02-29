import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model/UserModel.dart';
import 'package:flutter_mvvm/model_view/user_view_model.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../repo/auth_repository.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();
  bool loading = false;

  Future<void> loginApi(dynamic data, BuildContext context) async {
    loading = true;
    notifyListeners();

    _myRepo.loginApi(data).then((value) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Success", "Login Successful");
      final userModelViewModel =
            Provider.of<UserViewModel>(context, listen: false);

      userModelViewModel.saveUser(UserModel(token: value.toString()));
      print(value.toString());
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();

      Utils().showErrorFlushBar(context, "Error", error.toString());
    });
  }
}