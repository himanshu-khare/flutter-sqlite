import 'package:carousel_slider/carousel_controller.dart';
import 'package:fluttersqlite/core/constants/constants.dart';
import 'package:fluttersqlite/data/local/database_helper.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/team.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/teams_data_model.dart';
import 'package:fluttersqlite/presentation/home/cubit/home_cubit.dart';

mixin TeamMixin {
  int teamIndex = 0;
  late var allTeam = <Team>[];

  final carouselController = CarouselController();
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  incTeamIndex(HomeCubit homeCubit) {
    if (teamIndex < allTeam.length - 1) {
      teamIndex++;
    } else {
      teamIndex = 0;
    }
    carouselController.animateToPage(teamIndex);
    homeCubit.update();
  }

  void getTeams(HomeCubit homeCubit) async {
    try {
      final localTeams = await dbHelper.getTeams();
      if (localTeams.isEmpty) {
        allTeam = TeamsDataModel.fromJson(AppConstants.teamsdata).data ?? [];
        dbHelper.insertTeams(allTeam);
      } else {
        allTeam = localTeams;
      }
    } catch (err) {
      allTeam = [];
    }

    homeCubit.update();
  }

  decTeamIndex(HomeCubit homeCubit) {
    if (teamIndex == 0) {
      teamIndex = allTeam.length - 1;
    } else {
      teamIndex--;
    }
    carouselController.animateToPage(teamIndex);
    homeCubit.update();
  }

  updateTeamIndex(int value, HomeCubit homeCubit) {
    teamIndex = value;
    homeCubit.update();
  }
}
