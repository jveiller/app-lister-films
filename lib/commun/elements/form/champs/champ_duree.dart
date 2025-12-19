import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChampDuree extends StatelessWidget {
  final TextEditingController champHeureController;
  final TextEditingController champMinuteController;
  final String txt;
  final bool necessaire;
  const ChampDuree({
    super.key,
    required this.champHeureController,
    required this.champMinuteController,
    required this.txt,
    this.necessaire = false,
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
              width: 60,
              child: TextFormField(
                cursorColor: Colors.black,
                inputFormatters: [LengthLimitingTextInputFormatter(2)],
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
                validator: necessaire == true
                    ? (value) {
                        if (champMinuteController.text == '' &&
                            (value == null || value.isEmpty)) {
                          return 'Tu dois compléter ce champ';
                        }
                        return null;
                      }
                    : null,
                controller: champHeureController,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ComposantTexte(texte: 'h'),
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                cursorColor: Colors.black,
                inputFormatters: [LengthLimitingTextInputFormatter(2)],
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
                validator: necessaire == true
                    ? (value) {
                        if (champHeureController.text == '' &&
                            (value == null || value.isEmpty)) {
                          return 'Tu dois compléter ce champ';
                        }
                        return null;
                      }
                    : null,
                controller: champMinuteController,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ComposantTexte(texte: 'min'),
            ),
          ],
        ),
      ],
    );
  }
}
