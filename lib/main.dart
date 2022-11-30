import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'features/home/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: const ColorScheme.light().copyWith(
            primary: Colors.white,
            secondary: const Color(0xffff6868),
            background: const Color(0xffE7F6F2),
            onSecondary: Colors.white,
            tertiary: const Color(0xff2C3333)),
        primarySwatch: Colors.red,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const HomePage(),
    );
  }
}
