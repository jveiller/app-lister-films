import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/database/db_film_vu.dart';
import 'package:culture_app1/pages/films/bouton_trier_film.dart';
import 'package:culture_app1/pages/films/filmsVu/elements/boutons/bouton_ajouter_film_vu.dart';
import 'package:culture_app1/pages/films/filmsVu/elements/film_vu_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FilmsVuPage extends StatefulWidget {
  const FilmsVuPage({super.key});

  @override
  State<FilmsVuPage> createState() => _FilmsVuPageState();
}

class _FilmsVuPageState extends State<FilmsVuPage> {
  List<FilmsVu> _filmsVu =
      []; //activites = Liste d'une Map avec un String en clé et une valeur dont le type peut changer, initialisé vide
  List<FilmsVu> _afficheFilmVu = [];
  List<String> _genres = [];
  bool _initialise = false;
  final _searchController = TextEditingController();
  String tri = 'date';
  // Une fonction avec async est une fonction asynchrone, cela veut dire que le programme ne va pas attendre qu'elle est fini de s'executer pour
  // passer à la ligne suivante, elle peut donc s'executer en même temps que d'autres lignes, on met await devant les appel des fonctions asynchrones,
  // Une fonction qui retourne un élément de manière asynchrone est de type Future<>

  void _addFilmVu({
    required String titre,
    int? annee,
    int? duree,
    List<String>? genre,
    String? plateforme,
    String? description,
    double? note,
    List<String>? acteurs,
    List<String>? citations,
    String? realisateur,
    String? contexte,
    bool? cinema,
    DateTime? date,
  }) async {
    var box = await Hive.openBox('filmVu');
    int id = box.get('id') ?? 1;
    var newFilm = FilmsVu(
      id: id,
      titre: titre,
      annee: annee,
      duree: duree,
      genre: genre,
      plateforme: plateforme,
      description: description,
      note: note,
      acteurs: acteurs,
      citations: citations,
      realisateur: realisateur,
      contexte: contexte,
      date: date,
      cinema: cinema,
    );
    //Fonction pour ajouter une élément dans la base de données
    //Si l'élément renvoyé par le champ nom du form n'est pas null
    await DbFilmsVu.insert(
      newFilm,
    ); //Appel de la fonction insert de la class DbHelper avec actNameController mis en format text et selectedActType en paramètres
    _fetchFilmVu();
    id += 1;
    await box.put('id', id);
    await box.close();
  }

  void modifFilmVu({
    required FilmsVu fv,
    String? titre,
    List<String>? genre,
    int? annee,
    int? duree,
    double? note,
    String? plateforme,
    String? description,
    List<String>? acteurs,
    List<String>? citations,
    String? realisateur,
    String? contexte,
    bool? cinema,
    DateTime? date,
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
      fv.setCitations(citations);
      fv.setRealisateur(realisateur);
      fv.setCinema(cinema);
      fv.setContexte(contexte);
      fv.setDate(date);
      DbFilmsVu.update(fv);
    });
    _fetchFilmVu();
  }

  void _deleteFilmVu(int id) async {
    // Fonction pour supprimer un élément de la BdD dont l'id est id
    await DbFilmsVu.delete(id);
    _fetchFilmVu();
  }

  void _fetchFilmVu() async {
    // Actualise l'état de la BdD dans l'application
    final data =
        await DbFilmsVu.getList(); //  Donne à data les éléments de la BdD
    setState(() {
      // Mise à jour de l'état
      _filmsVu = List.from(
        data.reversed,
      ); // La variable activités prend les valeurs de data
      if (!_initialise) {
        _afficheFilmVu = _filmsVu;
        _initialise = true;
      } else {
        List<FilmsVu> listeModif = [];
        if (_searchController.text != '') {
          for (FilmsVu fv in _filmsVu) {
            if (fv.titre.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                ((fv.genre ?? []).join(',')).toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                (fv.realisateur ?? '').toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                ((fv.acteurs ?? []).join(',')).toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                (fv.plateforme ?? '').toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                )) {
              listeModif.add(fv);
            }
          }
        } else {
          listeModif = _filmsVu;
        }
        if (tri == 'date') {
          triAjout();
        } else if (tri == 'duree') {
          triDuree();
        } else if (tri == 'note') {
          triNote();
        }
        _afficheFilmVu = listeModif;
      }
    });
  }

  Future<void> addGenre(String g) async {
    if (!_genres.contains(g) && g != '') {
      var box = await Hive.openBox('film');
      setState(() {
        _genres.insert(0, g);
      });
      await box.put('genres', _genres);
      await loadGenre();
      await box.close();
    }
  }

  Future<bool> deleteGenre(String g) async {
    if (_genres.length > 1) {
      var box = await Hive.openBox('film');
      setState(() {
        _genres.remove(g);
      });
      await box.put('genres', _genres);
      await loadGenre();
      await box.close();
      return true;
    }
    return false;
  }

  Future<void> loadGenre() async {
    var box = await Hive.openBox('film');
    List<String>? g = box.get('genres');
    setState(() {
      _genres = g ?? ['Comédie'];
    });
    await box.close();
  }

  void triDuree() {
    setState(() {
      tri = 'duree';
      _filmsVu.sort(
        (a, b) => (a.duree ?? double.maxFinite.toInt()).compareTo(
          b.duree ?? double.maxFinite.toInt(),
        ),
      );
    });
  }

  void triNote() {
    setState(() {
      tri = 'note';
      _filmsVu.sort((a, b) => (b.note ?? 0).compareTo(a.note ?? 0));
    });
  }

  void triAjout() {
    setState(() {
      tri = 'date';
      _filmsVu.sort((a, b) => (b.id).compareTo(a.id));
    });
  }

  _onSearchChanged() {
    _fetchFilmVu();
  }

  @override //à mettre avant les méthodes utilisant des instances
  void initState() {
    //Donne les valeurs initiales de la BdD à activites
    super.initState();
    _fetchFilmVu();
    loadGenre();
    _searchController.addListener(_onSearchChanged);
  }

  bool vu = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
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
              width: 135,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: BoutonAjouterFilmVu(
                listeGenre: _genres,
                addFilmFonction: _addFilmVu,
                setFilmState: setState,
                addGenreFonction: addGenre,
                deleteGenreFonction: deleteGenre,
              ),
            ),
            Container(
              width: 130,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: BoutonTrierFilm(
                fonctionTriAjout: triAjout,
                fonctionTriDuree: triDuree,
                fonctionTriNote: triNote,
              ),
            ),
          ],
        ),
        if (_afficheFilmVu.isEmpty) ...[
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ComposantTexte(texte: 'Aucun résultat'),
          ),
        ],
        Expanded(
          child: ListView(
            children: [
              for (FilmsVu fv in _afficheFilmVu)
                FilmVuCard(
                  fv: fv,
                  supprFilmFonction: _deleteFilmVu,
                  listeGenres: _genres,
                  modifFilmFonction: modifFilmVu,
                  addGenreFonction: addGenre,
                  supprGenreFonction: deleteGenre,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
