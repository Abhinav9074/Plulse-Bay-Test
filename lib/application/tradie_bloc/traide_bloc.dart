import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/tradie_bloc/tradie_event.dart';
import 'package:pulse_bay/application/tradie_bloc/tradie_state.dart';
import 'package:pulse_bay/domain/api/api_data_fetch.dart';

class TradieBloc extends Bloc<TradieEvent,TradieState>{
  TradieBloc():super(TradieInitialState()){
    on<TradieDateFetchEvent>((event, emit)async{
      emit(TradieLoadingState());
      await fetchTradies(event.location);
      emit(TradieDataLoadedState());
    });
  }
}