import 'package:culture_app1/commun/app_bar.dart';
import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/couleur.dart';
import 'package:culture_app1/commun/database/db_serie.dart';
import 'package:culture_app1/pages/films/bouton_trier_film.dart';
import 'package:culture_app1/pages/series/elements/boutons/bouton_ajouter_serie.dart';
import 'package:culture_app1/pages/series/elements/selecteur3.dart';
import 'package:culture_app1/pages/series/elements/serie_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SeriePage extends StatefulWidget {
  const SeriePage({super.key});

  @override
  State<SeriePage> createState() => _SeriePageState();
}

class _SeriePageState extends State<SeriePage> {
  List<Serie> _series = [];
  List<Serie> _afficheSeries = [];
  List<String> _genres = [];
  List<String> _plateformes = [];
  List<String> _avecQui = [];
  List<String> _recommandations = [];
  String statutFiltre = 'a_voir';
  final _searchController = TextEditingController();
  String tri = 'date';
  late Box serieBox;
  late Box filmBox;

  void _addSerie({
    required String titre,
    List<String>? genre,
    List<String>? plateforme,
    int? annee,
    String? createur,
    List<String>? acteurs,
    String? description,
    List<String>? avecQui,
    List<String>? recommandePar,
    List<String>? citations,
    int? nbSaisons,
    int? nbEpisodesMoyen,
    int? dureeMoyenneEpisode,
    double? note,
  }) async {
    int id = serieBox.get('id') ?? 1;
    var nouvelleSerie = Serie(
      id: id,
      titre: titre,
      genre: genre,
      plateforme: plateforme,
      annee: annee,
      createur: createur,
      acteurs: acteurs,
      description: description,
      avecQui: avecQui,
      recommandePar: recommandePar,
      citations: citations,
      nbEpisodesMoyen: nbEpisodesMoyen,
      dureeMoyenneEpisode: dureeMoyenneEpisode,
      note: note,
    );
    nouvelleSerie.setNbSaisons(nbSaisons);
    await DbSerie.insert(nouvelleSerie);
    _fetchSeries();
    id += 1;
    await serieBox.put('id', id);
  }

  void modifSerie({
    required Serie serie,
    String? titre,
    List<String>? genre,
    List<String>? plateforme,
    int? annee,
    String? createur,
    List<String>? acteurs,
    String? description,
    List<String>? avecQui,
    List<String>? recommandePar,
    List<String>? citations,
    int? nbSaisons,
    int? nbEpisodesMoyen,
    int? dureeMoyenneEpisode,
    double? note,
  }) {
    setState(() {
      if (titre != null && titre != '') {
        serie.setTitre(titre);
      }
      serie.setGenre(genre);
      serie.setPlateforme(plateforme);
      serie.setAnnee(annee);
      serie.setCreateur(createur);
      serie.setActeurs(acteurs);
      serie.setDescription(description);
      serie.setAvecQui(avecQui);
      serie.setRecommandePar(recommandePar);
      serie.setCitations(citations);
      serie.setNbEpisodesMoyen(nbEpisodesMoyen);
      serie.setDureeMoyenneEpisode(dureeMoyenneEpisode);
      serie.setNote(note);
      serie.setNbSaisons(nbSaisons);
      DbSerie.update(serie);
    });
    _fetchSeries();
  }

  void _deleteSerie(int id) async {
    await DbSerie.delete(id);
    _fetchSeries();
  }

  // Sauvegarde centrale utilisée par les pop-up saison/épisode : si la
  // complétion des épisodes fait passer la série à "vu" (elle ne l'était
  // pas avant), on vide la note pour que l'utilisateur entre une note
  // d'appréciation neuve plutôt que de garder la note "envie de voir".
  Future<void> sauvegarderSerie(Serie serie, {bool? etaitVuAvant}) async {
    if (etaitVuAvant == false && serie.statut == 'vu') {
      serie.setNote(null);
    }
    await DbSerie.update(serie);
    _fetchSeries();
  }

  Future<void> toggleEpisodeVu(Serie serie, Episode episode) async {
    final etaitVuAvant = serie.statut == 'vu';
    episode.setVu(!episode.vu);
    await sauvegarderSerie(serie, etaitVuAvant: etaitVuAvant);
  }

  Future<void> definirPosition(
    Serie serie,
    int saisonNumero,
    int episodeNumero,
  ) async {
    final etaitVuAvant = serie.statut == 'vu';
    for (var s in serie.saisons) {
      for (var e in s.episodes) {
        e.setVu(
          s.numero < saisonNumero ||
              (s.numero == saisonNumero && e.numero <= episodeNumero),
        );
      }
    }
    await sauvegarderSerie(serie, etaitVuAvant: etaitVuAvant);
  }

  List<Serie> _filtrer(List<Serie> series) {
    var filtrees = series.where((s) => s.statut == statutFiltre).toList();
    if (_searchController.text == '') return filtrees;
    final q = _searchController.text.toLowerCase();
    return filtrees
        .where(
          (s) =>
              s.titre.toLowerCase().contains(q) ||
              ((s.genre ?? []).join(',')).toLowerCase().contains(q) ||
              (s.createur ?? '').toLowerCase().contains(q) ||
              ((s.acteurs ?? []).join(',')).toLowerCase().contains(q) ||
              ((s.plateforme ?? []).join(',')).toLowerCase().contains(q),
        )
        .toList();
  }

  void _fetchSeries() async {
    final data = await DbSerie.getList();
    setState(() {
      _series = List.from(data.reversed);
      if (tri == 'date') {
        triAjoutSerie();
      } else if (tri == 'duree') {
        triDureeSerie();
      } else if (tri == 'note') {
        triNoteSerie();
      }
    });
  }

  void changerStatutFiltre(String s) {
    setState(() {
      statutFiltre = s;
      _afficheSeries = _filtrer(_series);
    });
  }

  Future<void> addGenre(String g) async {
    if (!_genres.contains(g) && g != '') {
      setState(() => _genres.insert(0, g));
      await filmBox.put('genres', _genres);
      await loadGenre();
    }
  }

  Future<bool> deleteGenre(String g) async {
    if (_genres.length > 1) {
      setState(() => _genres.remove(g));
      await filmBox.put('genres', _genres);
      await loadGenre();
      return true;
    }
    return false;
  }

  Future<void> loadGenre() async {
    List<String>? g = filmBox.get('genres');
    setState(() => _genres = g ?? ['Comédie']);
  }

  Future<void> selectionnerGenre(String g) async {
    if (_genres.remove(g)) {
      setState(() => _genres.insert(0, g));
      await filmBox.put('genres', _genres);
      await loadGenre();
    }
  }

  Future<void> addPlateforme(String p) async {
    if (!_plateformes.contains(p) && p != '') {
      setState(() => _plateformes.insert(0, p));
      await filmBox.put('plateformes', _plateformes);
      await loadPlateforme();
    }
  }

  Future<bool> deletePlateforme(String p) async {
    if (_plateformes.length > 1) {
      setState(() => _plateformes.remove(p));
      await filmBox.put('plateformes', _plateformes);
      await loadPlateforme();
      return true;
    }
    return false;
  }

  Future<void> loadPlateforme() async {
    List<String>? p = filmBox.get('plateformes');
    setState(() => _plateformes = p ?? ['Netflix']);
  }

  Future<void> selectionnerPlateforme(String p) async {
    if (_plateformes.remove(p)) {
      setState(() => _plateformes.insert(0, p));
      await filmBox.put('plateformes', _plateformes);
      await loadPlateforme();
    }
  }

  Future<void> addAvecQui(String a) async {
    if (!_avecQui.contains(a) && a != '') {
      setState(() => _avecQui.insert(0, a));
      await filmBox.put('personnes', _avecQui);
      await loadAvecQui();
    }
  }

  Future<bool> deleteAvecQui(String a) async {
    if (_avecQui.length > 1) {
      setState(() => _avecQui.remove(a));
      await filmBox.put('personnes', _avecQui);
      await loadAvecQui();
      return true;
    }
    return false;
  }

  Future<void> loadAvecQui() async {
    List<String>? a = filmBox.get('personnes');
    setState(() => _avecQui = a ?? ['Maman']);
  }

  Future<void> selectionnerAvecQui(String a) async {
    if (_avecQui.remove(a)) {
      setState(() => _avecQui.insert(0, a));
      await filmBox.put('personnes', _avecQui);
      await loadAvecQui();
    }
  }

  Future<void> addRecommandation(String r) async {
    if (!_recommandations.contains(r) && r != '') {
      setState(() => _recommandations.insert(0, r));
      await filmBox.put('recommandations', _recommandations);
      await loadRecommandation();
    }
  }

  Future<bool> deleteRecommandation(String r) async {
    if (_recommandations.length > 1) {
      setState(() => _recommandations.remove(r));
      await filmBox.put('recommandations', _recommandations);
      await loadRecommandation();
      return true;
    }
    return false;
  }

  Future<void> loadRecommandation() async {
    List<String>? r = filmBox.get('recommandations');
    setState(() => _recommandations = r ?? ['Ami·e']);
  }

  Future<void> selectionnerRecommandation(String r) async {
    if (_recommandations.remove(r)) {
      setState(() => _recommandations.insert(0, r));
      await filmBox.put('recommandations', _recommandations);
      await loadRecommandation();
    }
  }

  int? _dureeEstimee(Serie s) {
    final saisons = s.nbSaisons ?? s.saisons.length;
    if (saisons == 0 || s.nbEpisodesMoyen == null || s.dureeMoyenneEpisode == null) {
      return null;
    }
    return saisons * s.nbEpisodesMoyen! * s.dureeMoyenneEpisode!;
  }

  void triDureeSerie() {
    setState(() {
      tri = 'duree';
      _series.sort(
        (a, b) => (_dureeEstimee(a) ?? double.maxFinite.toInt()).compareTo(
          _dureeEstimee(b) ?? double.maxFinite.toInt(),
        ),
      );
      _afficheSeries = _filtrer(_series);
    });
  }

  void triNoteSerie() {
    setState(() {
      tri = 'note';
      _series.sort((a, b) => (b.note ?? 0).compareTo(a.note ?? 0));
      _afficheSeries = _filtrer(_series);
    });
  }

  void triAjoutSerie() {
    setState(() {
      tri = 'date';
      _series.sort((a, b) => (b.id).compareTo(a.id));
      _afficheSeries = _filtrer(_series);
    });
  }

  _onSearchChanged() {
    _fetchSeries();
  }

  @override
  void initState() {
    super.initState();
    serieBox = Hive.box('serie');
    filmBox = Hive.box('film');
    _fetchSeries();
    loadGenre();
    loadPlateforme();
    loadAvecQui();
    loadRecommandation();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBarCommune(texteBar: 'SÉRIES', couleur: serieOrange),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 20,
              left: TailleAdaptateur.width(context, 20),
              right: TailleAdaptateur.width(context, 20),
            ),
            child: SearchBar(
              controller: _searchController,
              leading: const Icon(Icons.search),
              onSubmitted: (value) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),
          SizedBox(height: 15),
          Selecteur3(
            couleurOff: Color.fromARGB(255, 185, 175, 149),
            couleurOn: serieOrange,
            valeur: statutFiltre,
            txt1: 'À VOIR',
            txt2: 'EN COURS',
            txt3: 'VU',
            val1: 'a_voir',
            val2: 'en_cours',
            val3: 'vu',
            onTap: changerStatutFiltre,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: TailleAdaptateur.width(context, 135),
                margin: EdgeInsets.symmetric(
                  horizontal: TailleAdaptateur.width(context, 30),
                  vertical: 20,
                ),
                child: BoutonAjouterSerie(
                  listeGenres: _genres,
                  addGenreFonction: addGenre,
                  supprGenreFonction: deleteGenre,
                  selectionnerGenreFonction: selectionnerGenre,
                  listePlateformes: _plateformes,
                  addPlateformeFonction: addPlateforme,
                  supprPlateformeFonction: deletePlateforme,
                  selectionnerPlateformeFonction: selectionnerPlateforme,
                  listeAvecQui: _avecQui,
                  addAvecQuiFonction: addAvecQui,
                  supprAvecQuiFonction: deleteAvecQui,
                  selectionnerAvecQuiFonction: selectionnerAvecQui,
                  listeRecommandations: _recommandations,
                  addRecommandationFonction: addRecommandation,
                  supprRecommandationFonction: deleteRecommandation,
                  selectionnerRecommandationFonction:
                      selectionnerRecommandation,
                  setSerieState: setState,
                  addSerieFonction: _addSerie,
                ),
              ),
              Container(
                width: TailleAdaptateur.width(context, 130),
                margin: EdgeInsets.symmetric(
                  horizontal: TailleAdaptateur.width(context, 30),
                  vertical: 20,
                ),
                child: BoutonTrierFilm(
                  fonctionTriAjout: triAjoutSerie,
                  fonctionTriDuree: triDureeSerie,
                  fonctionTriNote: triNoteSerie,
                ),
              ),
            ],
          ),
          if (_afficheSeries.isEmpty) ...[
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ComposantTexte(texte: 'Aucun résultat'),
            ),
          ],
          Expanded(
            child: ListView(
              children: [
                for (Serie serie in _afficheSeries)
                  SerieCard(
                    serie: serie,
                    supprSerieFonction: _deleteSerie,
                    listeGenres: _genres,
                    addGenreFonction: addGenre,
                    supprGenreFonction: deleteGenre,
                    selectionnerGenreFonction: selectionnerGenre,
                    listePlateformes: _plateformes,
                    addPlateformeFonction: addPlateforme,
                    supprPlateformeFonction: deletePlateforme,
                    selectionnerPlateformeFonction: selectionnerPlateforme,
                    listeAvecQui: _avecQui,
                    addAvecQuiFonction: addAvecQui,
                    supprAvecQuiFonction: deleteAvecQui,
                    selectionnerAvecQuiFonction: selectionnerAvecQui,
                    listeRecommandations: _recommandations,
                    addRecommandationFonction: addRecommandation,
                    supprRecommandationFonction: deleteRecommandation,
                    selectionnerRecommandationFonction:
                        selectionnerRecommandation,
                    modifSerieFonction: modifSerie,
                    sauvegarderFonction: sauvegarderSerie,
                    toggleEpisodeVuFonction: toggleEpisodeVu,
                    definirPositionFonction: definirPosition,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
