import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model_view/user_view_model.dart';
import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed:() {
              final userViewModel = Provider.of<UserViewModel>(context, listen: false);
              userViewModel.removeUser();
              Navigator.pushNamed(context, RoutesName.login);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
        title: const Text('Home Screen'),
      ),
    );
  }
}