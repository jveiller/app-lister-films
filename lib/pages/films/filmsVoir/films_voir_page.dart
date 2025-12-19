import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:culture_app1/commun/composant_txt.dart';
import 'package:culture_app1/commun/database/db_film_voir.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/boutons/bouton_ajouter_film_voir.dart';
import 'package:culture_app1/pages/films/bouton_trier_film.dart';
import 'package:culture_app1/pages/films/filmsVoir/elements/film_voir_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FilmsVoirPage extends StatefulWidget {
  const FilmsVoirPage({super.key});

  @override
  State<FilmsVoirPage> createState() => _FilmsVoirPageState();
}

class _FilmsVoirPageState extends State<FilmsVoirPage> {
  List<FilmsVoir> _filmsVoir =
      []; //activites = Liste d'une Map avec un String en clé et une valeur dont le type peut changer, initialisé vide
  List<FilmsVoir> _afficheFilmVoir = [];
  List<String> _genres = [];
  bool _initialise = false;
  final _searchController = TextEditingController();
  // Une fonction avec async est une fonction asynchrone, cela veut dire que le programme ne va pas attendre qu'elle est fini de s'executer pour
  // passer à la ligne suivante, elle peut donc s'executer en même temps que d'autres lignes, on met await devant les appel des fonctions asynchrones,
  // Une fonction qui retourne un élément de manière asynchrone est de type Future<>

  void _addFilmVoir({
    required String titre,
    int? annee,
    int? duree,
    String? genre,
    String? plateforme,
    String? description,
    double? note,
    List<String>? acteurs,
    String? realisateur,
  }) async {
    var box = await Hive.openBox('filmVoir');
    int id = box.get('id') ?? 1;
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
    );
    //Fonction pour ajouter une élément dans la base de données
    //Si l'élément renvoyé par le champ nom du form n'est pas null
    await DbFilmsVoir.insert(
      newFilm,
    ); //Appel de la fonction insert de la class DbHelper avec actNameController mis en format text et selectedActType en paramètres
    _fetchFVoir();
    id += 1;
    await box.put('id', id);
    await box.close();
  }

  void modifFVoir({
    required FilmsVoir fv,
    String? titre,
    String? genre,
    int? annee,
    int? duree,
    double? note,
    String? plateforme,
    String? description,
    List<String>? acteurs,
    String? realisateur,
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
      DbFilmsVoir.update(fv);
    });
  }

  void _deleteFVoir(int id) async {
    // Fonction pour supprimer un élément de la BdD dont l'id est id
    await DbFilmsVoir.delete(id);
    _fetchFVoir();
  }

  void _fetchFVoir() async {
    // Actualise l'état de la BdD dans l'application
    final data =
        await DbFilmsVoir.getList(); //  Donne à data les éléments de la BdD
    setState(() {
      // Mise à jour de l'état
      _filmsVoir = List.from(
        data.reversed,
      ); // La variable activités prend les valeurs de data
      if (!_initialise) {
        _afficheFilmVoir = _filmsVoir;
        _initialise = true;
      } else {
        List<FilmsVoir> listeModif = [];
        if (_searchController.text != '') {
          for (FilmsVoir fv in _filmsVoir) {
            if (fv.titre.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                (fv.genre ?? '').toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                )) {
              listeModif.add(fv);
            }
          }
        } else {
          listeModif = _filmsVoir;
        }
        setState(() {
          _afficheFilmVoir = listeModif;
        });
      }
    });
  }

  Future<void> addGenre(String g) async {
    if (!_genres.contains(g)) {
      var box = await Hive.openBox('film');
      setState(() {
        _genres.add(g);
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
      _genres = g ?? ['Comedie'];
    });
    await box.close();
  }

  void triDureeFV() {
    setState(() {
      _filmsVoir.sort(
        (a, b) => (a.duree ?? double.maxFinite.toInt()).compareTo(
          b.duree ?? double.maxFinite.toInt(),
        ),
      );
    });
  }

  void triNoteFV() {
    setState(() {
      _filmsVoir.sort((a, b) => (b.note ?? 0).compareTo(a.note ?? 0));
    });
  }

  void triAjoutFV() {
    setState(() {
      _filmsVoir.sort((a, b) => (b.id).compareTo(a.id));
    });
  }

  void modifAfficheListe(String textVal) {
    _fetchFVoir();
    List<FilmsVoir> listeModif = [];
    if (textVal != '') {
      for (FilmsVoir fv in _filmsVoir) {
        if (fv.titre.toLowerCase().contains(textVal.toLowerCase()) ||
            (fv.genre ?? '').toLowerCase().contains(textVal.toLowerCase())) {
          listeModif.add(fv);
        }
      }
    } else {
      listeModif = _filmsVoir;
    }
    setState(() {
      _afficheFilmVoir = listeModif;
    });
  }

  _onSearchChanged() {
    _fetchFVoir();
  }

  @override //à mettre avant les méthodes utilisant des instances
  void initState() {
    //Donne les valeurs initiales de la BdD à activites
    super.initState();
    _fetchFVoir();
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
              child: BoutonAjouterFilmVoir(
                listeGenre: _genres,
                addFilmFonction: _addFilmVoir,
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
                ),
            ],
          ),
        ),
      ],
    );
  }
}
