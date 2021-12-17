import 'package:dating_app_user/routes.dart';
import 'package:dating_app_user/src/page/tab/discover/tinderCard/cardProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: "welcome_page",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
      ),
    );
  }
}
