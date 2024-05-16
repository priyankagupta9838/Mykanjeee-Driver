import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mykanjeedriver/routes/routes.dart';
import 'package:mykanjeedriver/routes/routesname.dart';
import 'Statemanagement/PageBlok.dart';



Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Driver',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}


