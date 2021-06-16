part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

@immutable
class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

@immutable
class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);

  @override
  List<Object> get props => [this.message];
}

@immutable
class HomeLoadedState extends HomeState {
  final HomeModel homeModel;

  HomeLoadedState(this.homeModel);

  @override
  List<Object> get props => [this.homeModel];
}

@immutable
class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

@immutable
class AddToFavoriteState extends HomeState {
  @override
  List<Object> get props => [];
}
