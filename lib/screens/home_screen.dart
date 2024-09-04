import 'package:flutter/material.dart';

import '../models/pokemon_card.dart';
import '../utils.dart';
import '../widgets/card_collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PokemonCard>> pokemonCards;

  @override
  void initState() {
    super.initState();

    // Read and parse JSON that contains the card list
    pokemonCards = fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemon Gallery',
          style: TextStyle(color: Color.fromARGB(255, 219, 211, 157)),
        ),
        backgroundColor: const Color.fromARGB(255, 78, 67, 33),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.brightness_2),
          ),
        ],
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<List<PokemonCard>>(
            future: pokemonCards,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return CardCollection(pokemonCards: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
