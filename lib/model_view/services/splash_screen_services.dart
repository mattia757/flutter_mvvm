import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model_view/services/splash_screen_services.dart';
import 'package:flutter_mvvm/model_view/user_view_model.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';

import '../../model/UserModel.dart';

class SplashScreenServices {
  Future<UserModel> getUserData() {
    return UserViewModel().getUser();
  }

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) {
      if (value.token == null) {
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        Navigator.pushNamed(context, RoutesName.home);
      }
    });
  }

}