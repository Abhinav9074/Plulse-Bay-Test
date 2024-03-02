import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_bay/application/region_bloc/region_event.dart';
import 'package:pulse_bay/application/region_bloc/region_state.dart';
import 'package:pulse_bay/domain/api/api_data_fetch.dart';

class RegionBloc extends Bloc<RegionEvent,RegionState>{
  RegionBloc():super(RegionInitialState()){
    on<RegionFetchEvent>((event, emit)async{
      emit(RegionLoadingState());
      await fetchRegions();
      emit(RegionLoadedState());
    });
  }
}