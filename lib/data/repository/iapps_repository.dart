import 'package:fluttersqlite/domain/entities/teams_data_model/player.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/team.dart';

abstract class IAppRepository {
  Future<List<Team>> getTeams();
  Future<int> updatePlayerByTeamId(Player updatedPlayer);
  Future<void> insertAllTeams(List<Team> teams);
}
