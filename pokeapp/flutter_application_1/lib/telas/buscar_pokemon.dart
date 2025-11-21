import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BuscaPokemonTela extends StatefulWidget {
  const BuscaPokemonTela({super.key});

  @override
  _BuscaPokemonTelaState createState() => _BuscaPokemonTelaState();
}

class _BuscaPokemonTelaState extends State<BuscaPokemonTela> {
  final TextEditingController _pokiController = TextEditingController();

  String _pokemonNome = '';
  String _pokemonImagem = '';
  int _pokemonId = 0;

  final Dio _dio = Dio();

  bool _isLoading = false;
  String _errorMessage = '';

  // --- PLAYER DE ÁUDIO ---
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Busca Pokémon')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _pokiController,
                decoration: InputDecoration(
                  labelText: 'Digite nome ou número do Pokémon',
                ),
              ),
              SizedBox(height: 30.0),

              ElevatedButton(
                onPressed: _isLoading ? null : _buscarPokemon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _isLoading ? 'Buscando...' : 'Buscar Pokémon',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 30),

              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                )
              else if (_pokemonNome.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text('ID: $_pokemonId', style: TextStyle(fontSize: 18)),
                      SizedBox(height: 5),
                      Text(
                        'Nome: $_pokemonNome',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      if (_pokemonImagem.isNotEmpty)
                        Image.network(_pokemonImagem, height: 150),

                      SizedBox(height: 10),

                      // BOTÃO PARA TOCAR O SOM
                      ElevatedButton.icon(
                        onPressed: _tocarSomPokemon,
                        icon: Icon(Icons.volume_up),
                        label: Text("Tocar som"),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pokiController.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _buscarPokemon() async {
    final pokemon = _pokiController.text.trim().toLowerCase();
    if (pokemon.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _pokemonNome = '';
      _pokemonImagem = '';
    });

    try {
      final url = 'https://pokeapi.co/api/v2/pokemon/$pokemon';

      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        setState(() {
          _pokemonId = data['id'];
          _pokemonNome = data['name'];
          _pokemonImagem = data['sprites']['front_default'];
        });
      } else {
        setState(() {
          _errorMessage = 'Pokémon não encontrado';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Erro ao buscar o Pokémon. Verifique o nome ou internet.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- FUNÇÃO PARA TOCAR O SOM DO POKÉMON ---
  Future<void> _tocarSomPokemon() async {
    if (_pokemonId == 0) return;

    final urlSom =
        "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/$_pokemonId.ogg";

    try {
      await _player.stop();
      await _player.play(UrlSource(urlSom));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao tocar o som")));
    }
  }
}
