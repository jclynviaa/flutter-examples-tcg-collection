import 'package:flutter/material.dart';

import '../models/pokemon_card.dart';
import '../utils.dart';
import '../widgets/card_collection.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PokemonCard>> pokemonCards;
  List<PokemonCard> checkedCards = [];

  @override
  void initState() {
    super.initState();

    // Read and parse JSON that contains the card list
    pokemonCards = fetchPokemonData();
  }

  void updatedCheckedCards(PokemonCard card) {
    setState(() {
      if (card.isChecked) {
        checkedCards.add(card);
      } else {
        checkedCards.remove(card);
      }
    });
  }

  void showCheckedCards() {
    if (checkedCards.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text("You haven't checked any card"),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: checkedCards.map((card) {
              return Text(card.name);
            }).toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemon Gallery',
          style: TextStyle(color: Color.fromARGB(255, 90, 79, 8)),
        ),
        backgroundColor: const Color.fromARGB(255, 204, 167, 65),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: showCheckedCards,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.dark
                    ? Icons.wb_sunny
                    : Icons.brightness_2,
              ),
              onPressed: widget.toggleTheme,
            ),
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
                return CardCollection(
                  pokemonCards: snapshot.data!,
                  updateCheckedCards: updatedCheckedCards,
                );
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
