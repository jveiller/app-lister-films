import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

class ChampTexte extends StatelessWidget {
  final String txt;
  final TextEditingController champController;
  final bool necessaire;
  final int? maxSize;
  final bool plusieursLignes;
  const ChampTexte({
    super.key,
    required this.txt,
    required this.champController,
    this.necessaire = false,
    this.maxSize,
    this.plusieursLignes = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: txt, weight: FontWeight.bold),
        TextFormField(
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            border: OutlineInputBorder(),
          ),
          maxLines: plusieursLignes ? null : 1,
          minLines: 1,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          validator: necessaire == true
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tu dois compléter ce texte';
                  }
                  return null;
                }
              : null,
          controller: champController,
        ),
      ],
    );
  }
}
