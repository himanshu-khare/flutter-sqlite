import 'team.dart';

class TeamsDataModel {
  List<Team>? data;

  TeamsDataModel({this.data});

  factory TeamsDataModel.fromJson(Map<String, dynamic> json) {
    return TeamsDataModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Team.fromMap(e as Map<String, dynamic>,[]))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toMap()).toList(),
      };
}
