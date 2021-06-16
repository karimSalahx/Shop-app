part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeProductsEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class FavoriteButtonClicked extends HomeEvent {
  final int productId;
  final String token;
  final HomeModel homeModel;
  FavoriteButtonClicked({@required this.productId, @required this.token , @required this.homeModel});
  @override
  List<Object> get props => [this.productId, this.token , this.homeModel];
}
