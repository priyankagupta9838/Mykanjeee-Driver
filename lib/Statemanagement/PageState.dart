


abstract class HomePageState{}

class InitStateOfHomePage extends HomePageState{}

class HomePageUpdateState extends HomePageState{}



abstract class AddTimerState{}

class InitStateOfAddTimer extends AddTimerState{}

class UpdateTimerState extends AddTimerState{}


abstract class ActiveUserState{}

class InitStateOfActiveUser extends ActiveUserState{}

class ActiveUserUpdateState extends ActiveUserState{}



abstract class AssignedServiceState{}

class InitStateOfAssignedService extends AssignedServiceState{}

class AssignedServiceUpdateState extends AssignedServiceState{}



abstract class PickUpServiceState{}

class InitStateOfPickUpService extends PickUpServiceState{}

class PickUpServiceUpdateState extends PickUpServiceState{}


abstract class DropOffServiceState{}

class InitStateOfDropOffService extends DropOffServiceState{}

class DropOffServiceUpdateState extends DropOffServiceState{}



abstract class AssignedOrderState{}

class InitStateOfAssignedOrder extends AssignedOrderState{}

class AssignedOrderUpdateState extends AssignedOrderState{}




abstract class AcceptedOrderState{}

class InitStateOfAcceptedOrder extends AcceptedOrderState{}

class AcceptedOrderUpdateState extends AcceptedOrderState{}


abstract class RejectedServiceState{}

class InitStateOfRejectedService extends RejectedServiceState{}

class RejectedServiceUpdateState extends RejectedServiceState{}



abstract class NotificationState{}

class InitStateOfNotification extends NotificationState{}

class UpdateNotificationState extends NotificationState{}
