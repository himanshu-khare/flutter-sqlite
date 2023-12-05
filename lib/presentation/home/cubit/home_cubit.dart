import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttersqlite/core/utils/extension.dart';
import 'package:fluttersqlite/data/local/database_helper.dart';
import 'package:fluttersqlite/data/repository/iapps_repository.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/team.dart';
import 'package:fluttersqlite/presentation/home/mixin/player_mixin.dart';
import 'package:fluttersqlite/presentation/home/mixin/team_mixin.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with PlayerMixin, TeamMixin {
  HomeCubit({required this.appRepository}) : super(HomeInitialState()) {
    _initalize();
  }
  IAppRepository appRepository;

  _initalize() {
    getTeams(this);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  void update() {
    emit(HomeLoadedState(teams: allTeam,teamIndex: teamIndex));
  }

  Color getCurrentTeamColor() {
    return HexColor.fromHex("#" + allTeam[teamIndex].color.toString());
  }
}
