import 'package:cart/home/bloc/shopping_bloc.dart';
import 'package:cart/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ShoppingBloc()..add(LoadItems()))
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'poppins'),
        home: const HomeView(),
      ),
    );
  }
}
