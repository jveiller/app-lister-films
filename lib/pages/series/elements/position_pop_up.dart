import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:culture_app1/commun/elements/form/champs/champ_nombre.dart';
import 'package:flutter/material.dart';

// Raccourci "j'en suis à saison X, épisode Y" : marque en un coup tous les
// épisodes précédents comme vus (et les suivants comme non vus). Fonctionne
// même sur une saison dont le nombre d'épisodes n'a pas été défini.
class PositionPopUp extends StatefulWidget {
  final Serie serie;
  final Function definirPositionFonction;
  const PositionPopUp({
    super.key,
    required this.serie,
    required this.definirPositionFonction,
  });

  @override
  State<PositionPopUp> createState() => _PositionPopUpState();
}

class _PositionPopUpState extends State<PositionPopUp> {
  late int saisonChoisie;
  final episodeController = TextEditingController(text: '1');
  final keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    saisonChoisie = widget.serie.saisons.isNotEmpty
        ? widget.serie.saisons.first.numero
        : 1;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.serie.saisons.isEmpty) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: ComposantTexte(texte: 'Ma position', weight: FontWeight.bold),
        content: ComposantTexte(
          texte: 'Définis d\'abord le nombre de saisons.',
          alignment: TextAlign.start,
        ),
        actions: [BoutonAnnuler(txt: 'Fermer')],
      );
    }
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: ComposantTexte(texte: 'Ma position', weight: FontWeight.bold),
          content: Form(
            key: keyForm,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ComposantTexte(texte: 'Saison', weight: FontWeight.bold),
                DropdownButtonFormField<int>(
                  value: saisonChoisie,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    for (var s in widget.serie.saisons)
                      DropdownMenuItem(
                        value: s.numero,
                        child: ComposantTexte(texte: 'Saison ${s.numero}'),
                      ),
                  ],
                  onChanged: (v) {
                    setStateDialog(() {
                      saisonChoisie = v!;
                      episodeController.text = '1';
                    });
                  },
                ),
                SizedBox(height: 10),
                ChampNombre(
                  txt: 'Épisode',
                  champController: episodeController,
                  largeur: 80,
                  nbMaxNombres: 3,
                  necessaire: true,
                ),
              ],
            ),
          ),
          actions: [
            BoutonAnnuler(),
            TextButton(
              onPressed: () {
                if (keyForm.currentState!.validate()) {
                  final episodeChoisi =
                      int.tryParse(episodeController.text) ?? 1;
                  widget.definirPositionFonction(
                    widget.serie,
                    saisonChoisie,
                    episodeChoisi,
                  );
                  Navigator.pop(context);
                }
              },
              child: ComposantTexte(texte: 'Valider'),
            ),
          ],
        );
      },
    );
  }
}
