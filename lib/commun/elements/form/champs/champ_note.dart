import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChampNote extends StatelessWidget {
  final TextEditingController champController;
  final String txt;
  final int nbMaxNombre;
  final bool necessaire;
  final int bareme;
  const ChampNote({
    super.key,
    required this.champController,
    this.txt = 'Note',
    this.nbMaxNombre = 4,
    this.necessaire = false,
    this.bareme = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ComposantTexte(texte: txt, weight: FontWeight.bold),
        Row(
          children: [
            SizedBox(
              width: TailleAdaptateur.width(context, 60),
              child: TextFormField(
                cursorColor: Colors.black,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(nbMaxNombre),
                ],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                controller: champController,
                validator: necessaire == true
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tu dois compléter ce champ';
                        }
                        return null;
                      }
                    : null,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ComposantTexte(texte: '/ $bareme'),
            ),
          ],
        ),
      ],
    );
  }
}
