import 'package:flutter_bloc/flutter_bloc.dart';
import 'PageEvents.dart';
import 'PageState.dart';



class HomePageBlo extends Bloc<HomePageEvent,HomePageState>{
  HomePageBlo(): super(InitStateOfHomePage()){

    on<HomePageUpdateEvent>((event, emit) => emit(HomePageUpdateState()));
    on<InitialEventOfHomePage>((event, emit) => emit(InitStateOfHomePage()));
  }
}


class AddTimerBlo extends Bloc<TimerEvent,AddTimerState>{
  AddTimerBlo(): super(InitStateOfAddTimer()){
    on<UpdateTimerEvent>((event, emit) => emit(UpdateTimerState()));
    on<InitialEventOfTimer>((event, emit) => emit(InitStateOfAddTimer()));

    // Timer stream update


  }
}





