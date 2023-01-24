import 'package:flutter/material.dart';

import 'features/home/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

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
      title: 'Judgely',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
