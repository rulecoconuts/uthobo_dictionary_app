import 'package:dictionary_app/accessors/routing_utils_accessor.dart';
import 'package:dictionary_app/config/main_config.dart';
import 'package:dictionary_app/services/flavor/app_flavor.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  MainConfig(appFlavor: AppFlavor.DEV).config();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget with RoutingUtilsAccessor {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      color: Colors.white,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF575353),
                fontSize: 15)),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 15)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
                backgroundColor: MaterialStateProperty.all(Color(0xFF203354)))),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 15),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF203354),
            primary: Color(0xFF203354),
            secondary: Color(0xFF5C6B85)),
        useMaterial3: true,
      ),
      routerDelegate: router().routerDelegate,
      routeInformationProvider: router().routeInformationProvider,
      routeInformationParser: router().routeInformationParser,
    );
  }
}
