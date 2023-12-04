import 'player.dart';

class Team {
  int? team;
  String? teamName;
  String? color;
  List<Player>? players;
  int playerIndex = 0;

  Team({this.team, this.teamName, this.color, this.players,this.playerIndex=0});
  Map<String, dynamic> toMap() {
    return {
      'team': team,
      'team_name': teamName,
      'color': color,
      'playerIndex':playerIndex
    };
  }

  factory Team.fromMap(Map<String, dynamic> map, List<Player> players) {
    return Team(
      team: map['team'],
      teamName: map['team_name'],
      color: map['color'],
      playerIndex: map['playerIndex'] ??0,
      players: map['players']!=null? ((map['players'] as List<dynamic>?)
          ?.map((e) => Player.fromMap(e as Map<String, dynamic>))
          .toList()) : players,
    );
  }
}
