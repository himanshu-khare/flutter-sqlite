import 'package:fluttersqlite/core/app_export.dart';
import 'package:fluttersqlite/data/repository/iapps_repository.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/player.dart';
import 'package:fluttersqlite/domain/entities/teams_data_model/team.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends IAppRepository{
  
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() => instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'teams_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE teams(
        team INTEGER PRIMARY KEY,
        team_name TEXT NOT NULL,
        color TEXT NOT NULL,
        playerIndex INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE players(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        teamId INTEGER NOT NULL,
        name TEXT NOT NULL,
        score TEXT ,
        FOREIGN KEY (teamId) REFERENCES teams(team)
      )
    ''');
  }

  Future<int> _insertTeam(Team team) async {
    try {
      Database db = await database;
      return await db.insert(AppConstants.teams, team.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      return -1;
    }
  }

  Future<void> insertAllTeams(List<Team> teams) async {
    try {
      for (var team in teams) {
        await _insertTeam(team);
        for (var player in team.players!) {
          await _insertPlayer(player, team.team!);
        }
      }
    } catch (err) {
      return;
    }
  }

  Future<int> _insertPlayer(Player player, int teamId) async {
    try {
      Database db = await database;
      player.teamId = teamId;
      return await db.insert('${AppConstants.players}',
          {'${AppConstants.teamId}': teamId, ...player.toMap()});
    } catch (err) {
      return -1;
    }
  }

  Future<List<Team>> getTeams() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> teamsMap = await db.query(AppConstants.teams);
      List<Team> teams = [];
      for (var teamMap in teamsMap) {
        List<Player> players = await _getPlayers(teamMap[AppConstants.team]);
        teams.add(Team.fromMap(teamMap, players));
      }
      return teams;
    } catch (err) {
      return [];
    }
  }

  Future<List<Player>> _getPlayers(int teamId) async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> playersMap = await db.query(
          AppConstants.players,
          where: '${AppConstants.teamId} = ?',
          whereArgs: [teamId]);
      return playersMap.map((playerMap) => Player.fromMap(playerMap)).toList();
    } catch (err) {
      return [];
    }
  }

  Future<int> updatePlayerByTeamId(Player updatedPlayer) async {
    try {
      Database db = await database;
      return await db.update(
        AppConstants.players,
        updatedPlayer.toMap(),
        where: '${AppConstants.teamId} = ? AND ${AppConstants.name} = ?',
        whereArgs: [updatedPlayer.teamId, updatedPlayer.name],
      );
    } catch (err) {
      return -1;
    }
  }
}
