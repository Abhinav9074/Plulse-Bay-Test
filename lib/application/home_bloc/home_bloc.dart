import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/home_bloc/home_event.dart';
import 'package:pulse_bay/application/home_bloc/home_state.dart';
import 'package:pulse_bay/domain/api/api_data_fetch.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc():super(HomeInitialState()){
    on<HomeDataFetchEvent>((event, emit)async{
      
      emit(HomeLoadingState());

      await fetchIndustry();

      emit(HomeLoadedState());

    });
  }
}