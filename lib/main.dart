import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mykanjeedriver/registration/accountdetail.dart';
import 'package:mykanjeedriver/routes/routes.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'NotificationSetup/helper_Notification.dart';
import 'Statemanagement/PageBlok.dart';
import 'constrant.dart';
import 'firebase_options.dart';




@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("App Background...${message.data}");
  NotificationServices.display(message,"404");

}

// on background
@pragma('vm:entry-point')
Future<void> firebaseMessagingonmessageHandler(RemoteMessage message) async {
  NotificationServices.display(message,"404");
  print("App Background...${message.data}");

}
@pragma('vm:entry-point')
Future<void> firebaseMessagingonmessageOpenedAppHandler(RemoteMessage message) async {

  print("App onend...${message.data}");
  NotificationServices.display(message,"404");

}



Future<void> main() async {
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box =GetStorage();
  @override
  void initState() {
    super.initState();
    userToken=box.read("UserToken").toString();
    NotificationServices.initialize(context);

    FirebaseMessaging.onMessage.listen(firebaseMessagingonmessageHandler);

    FirebaseMessaging.onBackgroundMessage.call(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(firebaseMessagingonmessageOpenedAppHandler);
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<HomePageBlo>(
          create: (BuildContext context) => HomePageBlo(),
        ),
        BlocProvider<AddTimerBlo>(
          create: (BuildContext context) => AddTimerBlo(),
        ),
        BlocProvider<ActiveUserBlo>(
          create: (BuildContext context) => ActiveUserBlo(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Driver',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        initialRoute:
        userToken!="null"
            ?
        RoutesName.storageStream
           :
        RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}


