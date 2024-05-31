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





class ActiveUserBlo extends Bloc<ActiveUserEvent,ActiveUserState>{
  ActiveUserBlo(): super(InitStateOfActiveUser()){

    on<ActiveUserUpdateEvent>((event, emit) => emit(ActiveUserUpdateState()));
    on<InitialEventOfActiveUser>((event, emit) => emit(InitStateOfActiveUser()));
  }
}


class AssignedServiceBlo extends Bloc<AssignedServiceEvent,AssignedServiceState>{
  AssignedServiceBlo(): super(InitStateOfAssignedService()){

    on<AssignedServiceUpdateEvent>((event, emit) => emit(AssignedServiceUpdateState()));
    on<InitialEventOfAssignedService>((event, emit) => emit(InitStateOfAssignedService()));
  }
}

class PickUpServiceBlo extends Bloc<PickUpServiceEvent,PickUpServiceState>{
  PickUpServiceBlo(): super(InitStateOfPickUpService()){

    on<PickUpServiceUpdateEvent>((event, emit) => emit(PickUpServiceUpdateState()));
    on<InitialEventOfPickUpService>((event, emit) => emit(InitStateOfPickUpService()));
  }
}


class DropOffServiceBlo extends Bloc<DropOffServiceEvent,DropOffServiceState>{
  DropOffServiceBlo(): super(InitStateOfDropOffService()){

    on<DropOffServiceUpdateEvent>((event, emit) => emit(DropOffServiceUpdateState()));
    on<InitialEventOfDropOffService>((event, emit) => emit(InitStateOfDropOffService()));
  }
}



class CollectedServiceBlo extends Bloc<CollectedServiceEvent,CollectedServiceState>{
  CollectedServiceBlo(): super(InitStateOfCollectedService()){

    on<CollectedServiceUpdateEvent>((event, emit) => emit(CollectedServiceUpdateState()));
    on<InitialEventOfCollectedService>((event, emit) => emit(InitStateOfCollectedService()));
  }
}



class DeliveredServiceBlo extends Bloc<DeliveredServiceEvent,DeliveredServiceState>{
  DeliveredServiceBlo(): super(InitStateOfDeliveredService()){

    on<DeliveredServiceUpdateEvent>((event, emit) => emit(DeliveredServiceUpdateState()));
    on<InitialEventOfDeliveredService>((event, emit) => emit(InitStateOfDeliveredService()));
  }
}


class RejectedServiceBlo extends Bloc<RejectedServiceEvent,RejectedServiceState>{
  RejectedServiceBlo(): super(InitStateOfRejectedService()){

    on<RejectedServiceUpdateEvent>((event, emit) => emit(RejectedServiceUpdateState()));
    on<InitialEventOfRejectedService>((event, emit) => emit(InitStateOfRejectedService()));
  }
}


