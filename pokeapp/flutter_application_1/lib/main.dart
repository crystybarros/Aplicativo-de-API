import 'package:flutter/material.dart';

// Importa sua tela de boas-vindas
import 'package:flutter_application_1/telas/welcome_page.dart';

void main() {
  runApp(Aplicacao());
}

class Aplicacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BuscarPokemon',
      debugShowCheckedModeBanner: false,

      // Tema estilizado
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.lightBlueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.lightBlueAccent),
          ),
          labelStyle: TextStyle(color: Colors.lightBlueAccent),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.lightBlueAccent,
          ),
        ),
      ),

      //Agora a tela inicial é a WelcomePage
      home: WelcomePage(),
    );
  }
}
