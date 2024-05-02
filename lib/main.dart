import 'package:flutter/material.dart';
import 'package:mykanjeedriver/routes/routes.dart';
import 'package:mykanjeedriver/routes/routesname.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     // home: const LogInPage(),
      initialRoute: RoutesName.login,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}


