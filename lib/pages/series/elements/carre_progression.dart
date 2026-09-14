import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:flutter/material.dart';

// Carré représentant une saison ou un épisode : plein si entièrement vu,
// contour coloré si en cours, vide sinon. `onToggle`, si fourni, ajoute une
// petite pastille dans le coin permettant de cocher/décocher rapidement sans
// ouvrir la pop-up (utilisé pour les épisodes).
class CarreProgression extends StatelessWidget {
  final String texte;
  final bool rempli;
  final bool enCours;
  final Color couleur;
  final VoidCallback onTap;
  final VoidCallback? onToggle;
  const CarreProgression({
    super.key,
    required this.texte,
    required this.rempli,
    required this.enCours,
    required this.couleur,
    required this.onTap,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final taille = TailleAdaptateur.width(context, 55);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: taille,
            height: taille,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: rempli ? couleur : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: enCours ? couleur : Colors.grey,
                width: enCours ? 3 : 1,
              ),
            ),
            child: Center(
              child: ComposantTexte(
                texte: texte,
                color: rempli ? Colors.white : Colors.black,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (onToggle != null)
          Positioned(
            top: -4,
            right: -4,
            child: InkWell(
              onTap: onToggle,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: rempli ? couleur : Colors.grey[300],
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Icon(Icons.check, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
