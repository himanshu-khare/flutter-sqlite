part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {} 

final class HomeLoadedState extends HomeState {
  final List<Team>? teams;
  HomeLoadedState({this.teams});
}