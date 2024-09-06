import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../models/pokemon_card.dart';
import 'card_item.dart';

class CardCollection extends StatelessWidget {
  final List<PokemonCard> pokemonCards;
  final Function(PokemonCard) updateCheckedCards;

  const CardCollection({
    super.key,
    required this.pokemonCards,
    required this.updateCheckedCards,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.7,
        crossAxisCount: 2,
      ),
      itemCount: pokemonCards.length,
      itemBuilder: (context, index) {
        return CardItem(
          pokemon: pokemonCards[index],
          updateCheckedCards: updateCheckedCards,
        );
      },
    );
  }
}
