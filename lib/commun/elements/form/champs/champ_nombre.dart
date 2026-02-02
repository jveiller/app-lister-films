import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChampNombre extends StatelessWidget {
  final String txt;
  final double largeur;
  final int? nbMaxNombres;
  final TextEditingController champController;
  final bool necessaire;
  const ChampNombre({
    super.key,
    required this.txt,
    required this.champController,
    this.largeur = double.infinity,
    this.nbMaxNombres,
    this.necessaire = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: txt, weight: FontWeight.bold),
        SizedBox(
          width: TailleAdaptateur.width(context, largeur),
          child: TextFormField(
            cursorColor: Colors.black,
            inputFormatters: nbMaxNombres != null
                ? [LengthLimitingTextInputFormatter(nbMaxNombres)]
                : null,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
            validator: necessaire == true
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tu dois compléter ce champ';
                    }
                    return null;
                  }
                : null,
            controller: champController,
          ),
        ),
      ],
    );
  }
}
