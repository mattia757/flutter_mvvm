import 'package:flutter/material.dart';
import 'package:flutter_mvvm/model_view/home_view_model.dart';
import 'package:provider/provider.dart';

import '../data/response/status.dart';
import '../model_view/user_view_model.dart';
import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = HomeViewModel();

  @override
  void initState() {
    _homeViewModel.fetchMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: ChangeNotifierProvider(
        create: (context) => _homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            switch (value.movieList.status) {
              case Status.loading:
                return const CircularProgressIndicator();
              case Status.error:
                return Text(value.movieList.message.toString());
              case Status.completed:
                return ListView.builder(
                  itemCount: value.movieList.data!.tvShows!.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(value.movieList.data!.tvShows![index].imageThumbnailPath.toString()),
                      title: Text(value.movieList.data!.tvShows![index].name.toString()),
                      subtitle: Text(value.movieList.data!.tvShows![index].startDate.toString()),
                    ),
                  );
                },);
              default:
                return const Text('Nothing to show');
            }
          },
        ),)
    );
  }
}