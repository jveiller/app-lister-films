import 'package:culture_app1/commun/classes/class_films_voir.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Création de la classe qui va manipuler la base de donnée
class DbFilmsVoir {
  static Database? _database;

  //Récupérer la base de données
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  //Initialiser la base de données
  static Future<Database> _initDatabase() async {
    //Création de la base de donnée activite.db ou importation de celle-ci si elle existe déjà
    String path = join(await getDatabasesPath(), 'filmsVoir3.db');
    return await openDatabase(
      path,
      version: 2,
      //Création de la table si nouvelle base de donnée
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE filmsVoir3 (id INTEGER PRIMARY KEY, titre TEXT, duree INTEGER, note DEC, genre TEXT, plateforme TEXT, annee INTEGER, description TEXT, acteurs TEXT,realisateur TEXT, recommandation TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE filmsVoir3 ADD COLUMN recommandation TEXT",
          );
        }
      },
    );
  }

  //INSERER une donnée dans la BDD
  static Future<int> insert(FilmsVoir film) async {
    final db = await getDatabase();
    String? acteurs;
    String? genres;
    String? plateformes;
    if (film.acteurs != null) {
      acteurs = film.acteurs!.join(',');
    } else {
      acteurs = null;
    }
    if (film.genre != null) {
      genres = film.genre!.join(',');
    } else {
      genres = null;
    }
    if (film.plateforme != null) {
      plateformes = film.plateforme!.join(',');
    } else {
      plateformes = null;
    }
    String? recommandation;
    if (film.recommandation != null) {
      recommandation = film.recommandation!.join(',');
    } else {
      recommandation = null;
    }
    return await db.insert('filmsVoir3', {
      'titre': film.titre,
      'duree': film.duree,
      'note': film.note,
      'genre': genres,
      'plateforme': plateformes,
      'annee': film.annee,
      'description': film.description,
      'acteurs': acteurs,
      'realisateur': film.realisateur,
      'recommandation': recommandation,
    });
  }

  //MODIFIER une donnée dans la BDD
  static Future<int> update(FilmsVoir fv) async {
    final db = await getDatabase();
    String? acteurs;
    String? genres;
    String? plateformes;
    if (fv.acteurs != null) {
      acteurs = fv.acteurs!.join(',');
    } else {
      acteurs = null;
    }
    if (fv.genre != null) {
      genres = fv.genre!.join(',');
    } else {
      genres = null;
    }
    if (fv.plateforme != null) {
      plateformes = fv.plateforme!.join(',');
    } else {
      plateformes = null;
    }
    String? recommandation;
    if (fv.recommandation != null) {
      recommandation = fv.recommandation!.join(',');
    } else {
      recommandation = null;
    }
    return await db.update(
      'filmsVoir3',
      {
        'titre': fv.titre,
        'duree': fv.duree,
        'note': fv.note,
        'genre': genres,
        'plateforme': plateformes,
        'annee': fv.annee,
        'description': fv.description,
        'acteurs': acteurs,
        'realisateur': fv.realisateur,
        'recommandation': recommandation,
      },
      where: 'id=?',
      whereArgs: [fv.id],
    );
  }

  //SUPPRIMER une donnée dans la BDD
  static Future<int> delete(int id) async {
    final db = await getDatabase();
    return await db.delete('filmsVoir3', where: 'id=?', whereArgs: [id]);
  }

  //LIRE les données de la BDD
  static Future<List<FilmsVoir>> getList() async {
    final db = await getDatabase();
    var listeData = await db.query('filmsVoir3');
    List<FilmsVoir> listeFilm = [];
    for (var film in listeData) {
      listeFilm.add(
        FilmsVoir(
          id: film['id'] as int,
          titre: film['titre'] as String,
          duree: film['duree'] == null ? null : film['duree'] as int,
          note: film['note'] == null
              ? null
              : film['note'] is int
              ? (film['note'] as int).toDouble()
              : film['note'] as double,
          genre: film['genre'] == null
              ? null
              : (film['genre'] as String).split(','),
          plateforme: film['plateforme'] == null
              ? null
              : (film['plateforme'] as String).split(','),
          annee: film['annee'] == null ? null : film['annee'] as int,
          description: film['description'] == null
              ? null
              : film['description'] as String,
          acteurs: film['acteurs'] == null
              ? null
              : (film['acteurs'] as String).split(','),
          realisateur: film['realisateur'] == null
              ? null
              : film['realisateur'] as String,
          recommandation: film['recommandation'] == null
              ? null
              : (film['recommandation'] as String).split(','),
        ),
      );
    }
    return listeFilm;
  }
}
