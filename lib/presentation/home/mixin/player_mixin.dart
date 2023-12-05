
import 'package:fluttersqlite/domain/entities/teams_data_model/player.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/team.dart';

import '../cubit/home_cubit.dart';

mixin PlayerMixin{

  incPlayerIndex(Team team,HomeCubit homeCubit) {
    if (team.playerIndex < team.players!.length - 1) {
      team.playerIndex++;
    } else {
      team.playerIndex = 0;
    }
   homeCubit.update();
  }

  decPlayerIndex(Team team,HomeCubit homeCubit) {
    if (team.playerIndex == 0) {
      team.playerIndex = team.players!.length - 1;
    } else {
      team.playerIndex--;
    }
   homeCubit.update();
  }

  incPlayerScore(Player player,HomeCubit homeCubit) {
    player.score = (int.parse(player.score!) + 1).toString();
    homeCubit.update();
    homeCubit.appRepository.updatePlayerByTeamId(player);
  }

  decPlayerScore(Player player,HomeCubit homeCubit) {
    if (player.score == "0") {
      player.score = "0";
    } else {
      player.score = (int.parse(player.score ?? "1") - 1).toString();
    }
    homeCubit.update();
    homeCubit.appRepository.updatePlayerByTeamId(player);
  }
}
