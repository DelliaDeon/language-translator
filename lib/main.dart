import 'package:flutter/material.dart';
import 'package:language_translator/home_screen.dart';

void main(){
  runApp(LanguageTranslator());
}

class LanguageTranslator extends StatelessWidget {
  const LanguageTranslator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',

      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
