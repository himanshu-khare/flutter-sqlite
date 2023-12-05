import 'package:flutter/cupertino.dart';

class Player {
  Player({this.name, this.score,this.teamId});
  String? score;
  final String? name;
  int? teamId;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'teamId':teamId
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'],
      score: map['score'],
      teamId: map['teamId']
    );
  }
}