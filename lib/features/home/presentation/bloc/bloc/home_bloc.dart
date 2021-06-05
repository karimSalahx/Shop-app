import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd_test/core/error/failures.dart';
import 'package:tdd_test/features/home/data/models/home_model.dart';
import 'package:tdd_test/features/home/domain/entity/home_entity.dart';
import 'package:tdd_test/features/home/domain/usecases/get_home_products.dart';
import 'package:tdd_test/usecases.dart';

part 'home_event.dart';
part 'home_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeProducts getHomeProducts;
  HomeBloc({@required this.getHomeProducts})
      : assert(getHomeProducts != null),
        super(HomeInitial());

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
