import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/elements/boutons/bouton_annuler.dart';
import 'package:culture_app1/pages/series/elements/carre_progression.dart';
import 'package:culture_app1/pages/series/elements/episode_pop_up.dart';
import 'package:culture_app1/pages/series/elements/forms/form_modif_saison.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaisonPopUp extends StatefulWidget {
  final Serie serie;
  final Saison saison;
  final List<String> listeAvecQui;
  final Function addAvecQuiFonction;
  final Function supprAvecQuiFonction;
  final Function selectionnerAvecQuiFonction;
  final Function sauvegarderFonction;
  final Function toggleEpisodeVuFonction;
  const SaisonPopUp({
    super.key,
    required this.serie,
    required this.saison,
    required this.listeAvecQui,
    required this.addAvecQuiFonction,
    required this.supprAvecQuiFonction,
    required this.selectionnerAvecQuiFonction,
    required this.sauvegarderFonction,
    required this.toggleEpisodeVuFonction,
  });

  @override
  State<SaisonPopUp> createState() => _SaisonPopUpState();
}

class _SaisonPopUpState extends State<SaisonPopUp> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        final saison = widget.saison;
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.all(10),
          actionsPadding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
          title: ComposantTexte(
            texte: 'Saison ${saison.numero}',
            size: 22,
            weight: FontWeight.bold,
          ),
          content: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (saison.nbEpisodes != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Nombre d\'épisodes',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(texte: saison.nbEpisodes.toString()),
                  ],
                ),
              ],
              if (saison.note != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(texte: 'Note', weight: FontWeight.bold),
                    ComposantTexte(texte: '${saison.note} / 10'),
                  ],
                ),
              ],
              if (saison.commentaire != null && saison.commentaire != '') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Commentaire',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: saison.commentaire!,
                      alignment: TextAlign.start,
                    ),
                  ],
                ),
              ],
              if (saison.dateDebutEffective != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Date de début',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: DateFormat(
                        'dd/MM/yyyy',
                      ).format(saison.dateDebutEffective!),
                    ),
                  ],
                ),
              ],
              if (saison.dateFinEffective != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComposantTexte(
                      texte: 'Date de fin',
                      weight: FontWeight.bold,
                    ),
                    ComposantTexte(
                      texte: DateFormat(
                        'dd/MM/yyyy',
                      ).format(saison.dateFinEffective!),
                    ),
                  ],
                ),
              ],
              if (saison.definie) ...[
                SizedBox(height: 10),
                ComposantTexte(texte: 'Épisodes', weight: FontWeight.bold),
                Wrap(
                  children: [
                    for (Episode e in saison.episodes)
                      CarreProgression(
                        texte: '${e.numero}',
                        rempli: e.vu,
                        enCours: false,
                        couleur: serieOrange,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => EpisodePopUp(
                              serie: widget.serie,
                              episode: e,
                              listeAvecQui: widget.listeAvecQui,
                              addAvecQuiFonction: widget.addAvecQuiFonction,
                              supprAvecQuiFonction:
                                  widget.supprAvecQuiFonction,
                              selectionnerAvecQuiFonction:
                                  widget.selectionnerAvecQuiFonction,
                              sauvegarderFonction: widget.sauvegarderFonction,
                            ),
                          ).then((_) => setStateDialog(() {}));
                        },
                        onToggle: () {
                          widget.toggleEpisodeVuFonction(widget.serie, e);
                          setStateDialog(() {});
                        },
                      ),
                  ],
                ),
              ],
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => FormModifSaison(
                            serie: widget.serie,
                            saison: saison,
                            setSaisonState: setStateDialog,
                            sauvegarderFonction: widget.sauvegarderFonction,
                          ),
                        );
                      },
                      child: ComposantTexte(texte: 'Modifier'),
                    ),
                    BoutonAnnuler(txt: 'Fermer'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
