import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/classes/taille_adaptateur.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/database/db_film_voir.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/boutons/bouton_ajouter_film_voir.dart';
import 'package:culture_app1/pages/films/bouton_trier_film.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/film_voir_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FilmsVoirPage extends StatefulWidget {
  final Function actualiseBDD;
  final List<FilmsVoir> listeFV;
  const FilmsVoirPage({
    super.key,
    required this.actualiseBDD,
    required this.listeFV,
  });

  @override
  State<FilmsVoirPage> createState() => _FilmsVoirPageState();
}

class _FilmsVoirPageState extends State<FilmsVoirPage> {
  List<FilmsVoir> _filmsVoir = [];
  List<FilmsVoir> _afficheFilmVoir = [];
  List<String> _genres = [];
  List<String> _plateformes = [];
  List<String> _recommandations = [];
  bool _initialise = false;
  final _searchController = TextEditingController();
  String tri = 'date';
  late Box filmBox;

  void _addFilmVoir({
    required String titre,
    int? annee,
    int? duree,
    List<String>? genre,
    List<String>? plateforme,
    String? description,
    double? note,
    List<String>? acteurs,
    String? realisateur,
    List<String>? recommandation,
  }) async {
    int id = filmBox.get('id') ?? 1;
    var newFilm = FilmsVoir(
      id: id,
      titre: titre,
      annee: annee,
      duree: duree,
      genre: genre,
      plateforme: plateforme,
      description: description,
      note: note,
      acteurs: acteurs,
      realisateur: realisateur,
      recommandation: recommandation,
    );
    //Fonction pour ajouter une élément dans la base de données
    await DbFilmsVoir.insert(newFilm);
    _fetchFVoir();
    id += 1;
    await filmBox.put('id', id);
  }

  void modifFVoir({
    required FilmsVoir fv,
    String? titre,
    List<String>? genre,
    int? annee,
    int? duree,
    double? note,
    List<String>? plateforme,
    String? description,
    List<String>? acteurs,
    String? realisateur,
    List<String>? recommandation,
  }) {
    setState(() {
      if (titre != null && titre != '') {
        fv.setTitre(titre);
      }
      fv.setAnnee(annee);
      fv.setNote(note);
      fv.setDuree(duree);
      fv.setGenre(genre);
      fv.setPlateforme(plateforme);
      fv.setDescription(description);
      fv.setActeurs(acteurs);
      fv.setRealisateur(realisateur);
      fv.setRecommandation(recommandation);
      DbFilmsVoir.update(fv);
    });
    _fetchFVoir();
  }

  void _deleteFVoir(int id) async {
    // Fonction pour supprimer un élément de la BdD dont l'id est id
    await DbFilmsVoir.delete(id);
    _fetchFVoir();
  }

  List<FilmsVoir> _filtrerRecherche(List<FilmsVoir> films) {
    if (_searchController.text == '') return films;
    final q = _searchController.text.toLowerCase();
    return films
        .where(
          (fv) =>
              fv.titre.toLowerCase().contains(q) ||
              ((fv.genre ?? []).join(',')).toLowerCase().contains(q) ||
              (fv.realisateur ?? '').toLowerCase().contains(q) ||
              ((fv.acteurs ?? []).join(',')).toLowerCase().contains(q) ||
              ((fv.plateforme ?? []).join(',')).toLowerCase().contains(q),
        )
        .toList();
  }

  void _fetchFVoir() async {
    // Actualise l'état de la BdD dans l'application
    final data =
        await DbFilmsVoir.getList(); //  Donne à data les éléments de la BdD
    setState(() {
      // Mise à jour de l'état
      _filmsVoir = List.from(
        data.reversed,
      ); // La variable _filmsVoir prend les valeurs de data
      widget.actualiseBDD();
      if (!_initialise) {
        _afficheFilmVoir = _filmsVoir;
        _initialise = true;
      } else {
        if (tri == 'date') {
          triAjoutFV();
        } else if (tri == 'duree') {
          triDureeFV();
        } else if (tri == 'note') {
          triNoteFV();
        }
      }
    });
  }

  Future<void> addGenre(String g) async {
    if (!_genres.contains(g) && g != '') {
      setState(() {
        _genres.insert(0, g);
      });
      await filmBox.put('genres', _genres);
      await loadGenre();
    }
  }

  Future<bool> deleteGenre(String g) async {
    if (_genres.length > 1) {
      setState(() {
        _genres.remove(g);
      });
      await filmBox.put('genres', _genres);
      await loadGenre();
      return true;
    }
    return false;
  }

  Future<void> loadGenre() async {
    List<String>? g = filmBox.get('genres');
    setState(() {
      _genres = g ?? ['Comédie'];
    });
  }

  Future<void> addPlateforme(String p) async {
    if (!_plateformes.contains(p) && p != '') {
      setState(() {
        _plateformes.insert(0, p);
      });
      await filmBox.put('plateformes', _plateformes);
      await loadPlateforme();
    }
  }

  Future<bool> deletePlateforme(String p) async {
    if (_plateformes.length > 1) {
      setState(() {
        _plateformes.remove(p);
      });
      await filmBox.put('plateformes', _plateformes);
      await loadPlateforme();
      return true;
    }
    return false;
  }

  Future<void> loadPlateforme() async {
    List<String>? p = filmBox.get('plateformes');
    setState(() {
      _plateformes = p ?? ['Netflix'];
    });
  }

  Future<void> addRecommandation(String r) async {
    if (!_recommandations.contains(r) && r != '') {
      setState(() {
        _recommandations.insert(0, r);
      });
      await filmBox.put('recommandations', _recommandations);
      await loadRecommandation();
    }
  }

  Future<bool> deleteRecommandation(String r) async {
    if (_recommandations.length > 1) {
      setState(() {
        _recommandations.remove(r);
      });
      await filmBox.put('recommandations', _recommandations);
      await loadRecommandation();
      return true;
    }
    return false;
  }

  Future<void> loadRecommandation() async {
    List<String>? r = filmBox.get('recommandations');
    setState(() {
      _recommandations = r ?? ['Ami·e'];
    });
  }

  void triDureeFV() {
    setState(() {
      tri = 'duree';
      _filmsVoir.sort(
        (a, b) => (a.duree ?? double.maxFinite.toInt()).compareTo(
          b.duree ?? double.maxFinite.toInt(),
        ),
      );
      _afficheFilmVoir = _filtrerRecherche(_filmsVoir);
    });
  }

  void triNoteFV() {
    setState(() {
      tri = 'note';
      _filmsVoir.sort((a, b) => (b.note ?? 0).compareTo(a.note ?? 0));
      _afficheFilmVoir = _filtrerRecherche(_filmsVoir);
    });
  }

  void triAjoutFV() {
    setState(() {
      tri = 'date';
      _filmsVoir.sort((a, b) => (b.id).compareTo(a.id));
      _afficheFilmVoir = _filtrerRecherche(_filmsVoir);
    });
  }

  _onSearchChanged() {
    _fetchFVoir();
  }

  @override //à mettre avant les méthodes utilisant des instances
  void initState() {
    //Donne les valeurs initiales de la BdD à _filmsVoir, genres et plateformes
    super.initState();
    filmBox = Hive.box('film');
    _fetchFVoir();
    loadGenre();
    loadPlateforme();
    loadRecommandation();
    _searchController.addListener(_onSearchChanged);
  }

  bool vu = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: TailleAdaptateur.width(context, 135),
              margin: EdgeInsets.symmetric(
                horizontal: TailleAdaptateur.width(context, 30),
                vertical: 20,
              ),
              child: BoutonAjouterFilmVoir(
                listeGenre: _genres,
                addFilmFonction: _addFilmVoir,
                setFilmState: setState,
                addGenreFonction: addGenre,
                deleteGenreFonction: deleteGenre,
                listePlateformes: _plateformes,
                addPlateformeFonction: addPlateforme,
                supprPlateformeFonction: deletePlateforme,
                listeRecommandations: _recommandations,
                addRecommandationFonction: addRecommandation,
                supprRecommandationFonction: deleteRecommandation,
              ),
            ),
            Container(
              width: TailleAdaptateur.width(context, 130),
              margin: EdgeInsets.symmetric(
                horizontal: TailleAdaptateur.width(context, 30),
                vertical: 20,
              ),
              child: BoutonTrierFilm(
                fonctionTriAjout: triAjoutFV,
                fonctionTriDuree: triDureeFV,
                fonctionTriNote: triNoteFV,
              ),
            ),
          ],
        ),
        if (_afficheFilmVoir.isEmpty) ...[
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ComposantTexte(texte: 'Aucun résultat'),
          ),
        ],
        Expanded(
          child: ListView(
            children: [
              for (FilmsVoir fv in _afficheFilmVoir)
                FilmVoirCard(
                  fv: fv,
                  supprFilmFonction: _deleteFVoir,
                  listeGenres: _genres,
                  modifFilmFonction: modifFVoir,
                  addGenreFonction: addGenre,
                  supprGenreFonction: deleteGenre,
                  listePlateformes: _plateformes,
                  addPlateformeFonction: addPlateforme,
                  supprPlateformeFonction: deletePlateforme,
                  listeRecommandations: _recommandations,
                  addRecommandationFonction: addRecommandation,
                  supprRecommandationFonction: deleteRecommandation,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
