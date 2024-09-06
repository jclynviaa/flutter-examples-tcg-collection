import 'package:flutter/material.dart';

import '../models/pokemon_card.dart';

class CheckBox extends StatefulWidget {
  const CheckBox(
      {super.key, required this.pokemon, required this.updateCheckedCards});

  final PokemonCard pokemon;
  final Function(PokemonCard) updateCheckedCards;

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.pokemon.toggleIsChecked();
          widget.updateCheckedCards(widget.pokemon);
        });
      },
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(4),
        child: Icon(
          widget.pokemon.isChecked
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank,
        ),
      ),
    );
  }
}
