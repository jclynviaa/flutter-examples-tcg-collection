import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/custom_image_network.dart';

import '../models/pokemon_card.dart';

class PokemonScreen extends StatelessWidget {
  final PokemonCard pokemon;

  const PokemonScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect()],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomImageNetwork(imageUrl: pokemon.imageHigh),
      ),
    );
  }
}
