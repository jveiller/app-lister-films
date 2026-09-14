import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:flutter/material.dart';

// Raccourci "j'en suis à saison X, épisode Y" : marque en un coup tous les
// épisodes précédents comme vus (et les suivants comme non vus).
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
  late int episodeChoisi;

  List<Saison> get saisonsDefinies =>
      widget.serie.saisons.where((s) => s.definie).toList();

  @override
  void initState() {
    super.initState();
    saisonChoisie = saisonsDefinies.isNotEmpty
        ? saisonsDefinies.first.numero
        : 1;
    episodeChoisi = 1;
  }

  @override
  Widget build(BuildContext context) {
    if (saisonsDefinies.isEmpty) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: ComposantTexte(texte: 'Ma position', weight: FontWeight.bold),
        content: ComposantTexte(
          texte:
              'Définis d\'abord le nombre d\'épisodes d\'au moins une saison.',
          alignment: TextAlign.start,
        ),
        actions: [BoutonAnnuler(txt: 'Fermer')],
      );
    }
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        final saison = saisonsDefinies.firstWhere(
          (s) => s.numero == saisonChoisie,
          orElse: () => saisonsDefinies.first,
        );
        return AlertDialog(
          backgroundColor: Colors.white,
          title: ComposantTexte(texte: 'Ma position', weight: FontWeight.bold),
          content: Column(
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
                  for (var s in saisonsDefinies)
                    DropdownMenuItem(
                      value: s.numero,
                      child: ComposantTexte(texte: 'Saison ${s.numero}'),
                    ),
                ],
                onChanged: (v) {
                  setStateDialog(() {
                    saisonChoisie = v!;
                    episodeChoisi = 1;
                  });
                },
              ),
              SizedBox(height: 10),
              ComposantTexte(texte: 'Épisode', weight: FontWeight.bold),
              DropdownButtonFormField<int>(
                value: episodeChoisi,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (var e in saison.episodes)
                    DropdownMenuItem(
                      value: e.numero,
                      child: ComposantTexte(texte: 'Épisode ${e.numero}'),
                    ),
                ],
                onChanged: (v) => setStateDialog(() => episodeChoisi = v!),
              ),
            ],
          ),
          actions: [
            BoutonAnnuler(),
            TextButton(
              onPressed: () {
                widget.definirPositionFonction(
                  widget.serie,
                  saisonChoisie,
                  episodeChoisi,
                );
                Navigator.pop(context);
              },
              child: ComposantTexte(texte: 'Valider'),
            ),
          ],
        );
      },
    );
  }
}
