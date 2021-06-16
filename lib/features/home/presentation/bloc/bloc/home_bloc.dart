import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd_test/features/home/domain/usecases/add_remove_product_to_favorites.dart';
import '../../../../../core/error/failures.dart';
import '../../../data/models/home_model.dart';
import '../../../domain/entity/home_entity.dart';
import '../../../domain/usecases/get_home_products.dart';
import '../../../../../usecases.dart';

part 'home_event.dart';

part 'home_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeProducts getHomeProducts;
  final AddRemoveProductToFavorites addRemoveProductToFavorites;

  HomeBloc({
    @required this.getHomeProducts,
    @required this.addRemoveProductToFavorites,
  })  : assert(getHomeProducts != null && addRemoveProductToFavorites != null),
        super(HomeInitial());

  bool isLiked = false;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetHomeProductsEvent) {
      yield HomeLoadingState();
      final _homeEither = await getHomeProducts(NoParam());
      yield* _homeEither.fold(
        (Failures l) async* {
          yield HomeErrorState(_mapErrorStateToMessage(l));
        },
        (HomeEntity r) async* {
          yield HomeLoadedState(r);
        },
      );
    } else if (event is FavoriteButtonClicked) {
      final _modelEither = await addRemoveProductToFavorites(
        ProductParam(
          event.productId,
          event.token,
        ),
      );
      yield* _modelEither.fold(
        (Failures l) async* {
          yield _mapErrorStateToMessage(l);
        },
        (r) async* {
          yield AddToFavoriteState();
        },
      );
    }
  }
}

String _mapErrorStateToMessage(Failures l) {
  switch (l.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
      break;

    default:
      return 'Unexpected Error';
      break;
  }
}
