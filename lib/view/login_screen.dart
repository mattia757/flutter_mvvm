import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model_view/auth_view_model.dart';
import '../resources/components/rounded_button.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
                hintStyle: TextStyle(
                  color: AppColors.hintTextStyleColor,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: AppColors.iconColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onFieldSubmitted: (value) {
                Utils().onChangeFocusNode(context, _emailFocusNode, _passwordFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _obscureText,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText.value,
                  obscuringCharacter: '*',
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    hintStyle: TextStyle(
                      color: AppColors.hintTextStyleColor,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_clock_outlined,
                      color: AppColors.iconColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _obscureText.value = !_obscureText.value;
                      },
                      child: Icon(
                        _obscureText.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.iconColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20,),
            Consumer<AuthViewModel>(
                builder: (context, authViewModel, child) {
                  return RoundedButton(title: "Login", onPress: () {
                    if(_emailController.text.isEmpty) {
                      Utils().showErrorFlushBar(context, 'Email is required', 'Please Fill the Email');
                    } else if(_passwordController.text.isEmpty) {
                      Utils().showErrorFlushBar(context, 'Password is required', 'Please Fill the Password');
                    } else if (_passwordController.text.length < 6) {
                      Utils().showErrorFlushBar(context, 'Password is too short', 'Password must be at least 6 characters');
                    }
                    else {
                      Map data = {
                        "email": _emailController.text.toString(),
                        "password": _passwordController.text.toString(),
                      };
                      authViewModel.loginApi(data, context);

                      print("API is Hit");
                    }
                  });
                }
            ),
          ],
        ),
      ),
    );
  }
}
