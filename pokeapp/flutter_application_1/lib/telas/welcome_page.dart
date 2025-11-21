import 'package:flutter/material.dart';
import 'buscar_pokemon.dart'; // importe sua tela principal

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              // TÍTULO
              Text(
                'Bem-vindo!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 20),
              // Imagem
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/pokemon.jpeg', // Caminho da imagem
                    width: 350,
                    height: 250,
                  ),
                ],
              ),
              const SizedBox(height: 1),

              Text(
                'Clique no botão para iniciar a busca por Pokémon.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(227, 249, 255, 77),
                ),
              ),

              SizedBox(height: 40),

              // BOTÃO ENTRAR
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // Navega para a página de busca
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuscaPokemonTela()),
                  );
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
