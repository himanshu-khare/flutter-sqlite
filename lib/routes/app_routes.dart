import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersqlite/data/local/database_helper.dart';
import 'package:fluttersqlite/presentation/home/cubit/home_cubit.dart';
import 'package:fluttersqlite/presentation/home/home_screen.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) {
      final homeCubit = HomeCubit(appRepository: DatabaseHelper.instance);
      return BlocProvider(
        create: (context) =>homeCubit,
        child: HomeScreen(homeCubit),
      );
    },
  };
}
