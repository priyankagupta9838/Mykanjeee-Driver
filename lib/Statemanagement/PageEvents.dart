



abstract class HomePageEvent{}

class HomePageUpdateEvent extends HomePageEvent{}

class InitialEventOfHomePage extends HomePageEvent{}




abstract class TimerEvent{}

class UpdateTimerEvent extends TimerEvent{}

class InitialEventOfTimer extends TimerEvent{}


abstract class ActiveUserEvent{}

class ActiveUserUpdateEvent extends ActiveUserEvent{}

class InitialEventOfActiveUser extends ActiveUserEvent{}



abstract class AssignedServiceEvent{}

class AssignedServiceUpdateEvent extends AssignedServiceEvent{}

class InitialEventOfAssignedService extends AssignedServiceEvent{}


abstract class PickUpServiceEvent{}

class PickUpServiceUpdateEvent extends PickUpServiceEvent{}

class InitialEventOfPickUpService extends PickUpServiceEvent{}


abstract class DropOffServiceEvent{}

class DropOffServiceUpdateEvent extends DropOffServiceEvent{}

class InitialEventOfDropOffService extends DropOffServiceEvent{}



abstract class AssignedOrderEvent{}

class AssignedOrderUpdateEvent extends AssignedOrderEvent{}

class InitialEventOfAssignedOrder extends AssignedOrderEvent{}





abstract class AcceptedOrderEvent{}

class AcceptedOrderUpdateEvent extends AcceptedOrderEvent{}

class InitialEventOfAcceptedOrder extends AcceptedOrderEvent{}



abstract class RejectedServiceEvent{}

class RejectedServiceUpdateEvent extends RejectedServiceEvent{}

class InitialEventOfRejectedService extends RejectedServiceEvent{}





abstract class NotificationEvent{}

class UpdateNotificationEvent extends NotificationEvent{}

class InitialEventOfNotification extends NotificationEvent{}