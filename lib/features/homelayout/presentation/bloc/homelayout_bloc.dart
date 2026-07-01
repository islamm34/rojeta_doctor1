import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_homelayout.dart';
import 'homelayout_event.dart';
import 'homelayout_state.dart';

class HomelayoutBloc extends Bloc<HomelayoutEvent, HomelayoutState> {
  final GetHomelayoutUseCase getHomelayout;

  HomelayoutBloc({required this.getHomelayout})
      : super(const HomelayoutState()) {
    on<LoadHomelayoutEvent>(_onLoad);
  }

  FutureOr<void> _onLoad(
      LoadHomelayoutEvent event, Emitter<HomelayoutState> emit) async {
    emit(state.copyWith(status: HomelayoutStatus.loading));
    try {
      await getHomelayout(); // simple version
      emit(state.copyWith(status: HomelayoutStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: HomelayoutStatus.error, message: e.toString()));
    }
  }
}
