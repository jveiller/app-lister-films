import 'package:culture_app1/commun/classes/class_films_vu.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Création de la classe qui va manipuler la base de donnée
class DbFilmsVu {
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
    String path = join(await getDatabasesPath(), 'filmsVu2.db');
    return await openDatabase(
      path,
      version: 5,
      //Création de la table si nouvelle base de donnée
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE filmsVu2 (id INTEGER PRIMARY KEY, titre TEXT, duree INTEGER, note DEC, genre TEXT, plateforme TEXT, annee INTEGER, description TEXT, acteurs TEXT, citations TEXT, realisateur TEXT, cinema BOOLEAN, contexte TEXT, date TEXT, accompagne BOOLEAN, personnes TEXT, cinemas TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute("ALTER TABLE filmsVu2 ADD COLUMN cinema BOOLEAN");
          await db.execute("ALTER TABLE filmsVu2 ADD COLUMN contexte TEXT");
          await db.execute("ALTER TABLE filmsVu2 ADD COLUMN date TEXT");
        }
        if (oldVersion < 4) {
          await db.execute(
            "ALTER TABLE filmsVu2 ADD COLUMN accompagne BOOLEAN",
          );
          await db.execute("ALTER TABLE filmsVu2 ADD COLUMN personnes TEXT");
        }
        if (oldVersion < 5) {
          await db.execute("ALTER TABLE filmsVu2 ADD COLUMN cinemas TEXT");
        }
      },
    );
  }

  //INSERER une donnée dans la BDD
  static Future<int> insert(FilmsVu film) async {
    final db = await getDatabase();
    String? acteurs;
    String? citations;
    String? genres;
    String? plateformes;
    if (film.plateforme != null) {
      plateformes = film.plateforme!.join(',');
    } else {
      plateformes = null;
    }
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
    if (film.citations != null) {
      citations = film.citations!.join(',');
    } else {
      citations = null;
    }
    String? personnes;
    if (film.personnes != null) {
      personnes = film.personnes!.join(',');
    } else {
      personnes = null;
    }
    String? cinemas;
    if (film.cinemas != null) {
      cinemas = film.cinemas!.join(',');
    } else {
      cinemas = null;
    }
    return await db.insert('filmsVu2', {
      'titre': film.titre,
      'duree': film.duree,
      'note': film.note,
      'genre': genres,
      'plateforme': plateformes,
      'annee': film.annee,
      'description': film.description,
      'acteurs': acteurs,
      'citations': citations,
      'realisateur': film.realisateur,
      'cinema': film.cinema,
      'contexte': film.contexte,
      'date': film.date == null
          ? null
          : DateFormat("dd/MM/yyyy").format(film.date!),
      'accompagne': film.accompagne,
      'personnes': personnes,
      'cinemas': cinemas,
    });
  }

  //MODIFIER une donnée dans la BDD
  static Future<int> update(FilmsVu fv) async {
    final db = await getDatabase();
    String? acteurs;
    String? citations;
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
    if (fv.citations != null) {
      citations = fv.citations!.join(',');
    } else {
      citations = null;
    }
    if (fv.plateforme != null) {
      plateformes = fv.plateforme!.join(',');
    } else {
      plateformes = null;
    }
    String? personnes;
    if (fv.personnes != null) {
      personnes = fv.personnes!.join(',');
    } else {
      personnes = null;
    }
    String? cinemas;
    if (fv.cinemas != null) {
      cinemas = fv.cinemas!.join(',');
    } else {
      cinemas = null;
    }
    return await db.update(
      'filmsVu2',
      {
        'titre': fv.titre,
        'duree': fv.duree,
        'note': fv.note,
        'genre': genres,
        'plateforme': plateformes,
        'annee': fv.annee,
        'description': fv.description,
        'acteurs': acteurs,
        'citations': citations,
        'realisateur': fv.realisateur,
        'cinema': fv.cinema,
        'contexte': fv.contexte,
        'date': fv.date == null
            ? null
            : DateFormat("dd/MM/yyyy").format(fv.date!),
        'accompagne': fv.accompagne,
        'personnes': personnes,
        'cinemas': cinemas,
      },
      where: 'id=?',
      whereArgs: [fv.id],
    );
  }

  //SUPPRIMER une donnée dans la BDD
  static Future<int> delete(int id) async {
    final db = await getDatabase();
    return await db.delete('filmsVu2', where: 'id=?', whereArgs: [id]);
  }

  //LIRE les données de la BDD
  static Future<List<FilmsVu>> getList() async {
    final db = await getDatabase();
    var listeData = await db.query('filmsVu2');
    List<FilmsVu> listeFilm = [];
    for (var film in listeData) {
      listeFilm.add(
        FilmsVu(
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
          citations: film['citations'] == null
              ? null
              : (film['citations'] as String).split(','),
          realisateur: film['realisateur'] == null
              ? null
              : film['realisateur'] as String,
          cinema: film['cinema'] == null
              ? null
              : film['cinema'] == 1
              ? true
              : false,
          contexte: film['contexte'] == null
              ? null
              : film['contexte'] as String,
          date: film['date'] == null
              ? null
              : DateFormat("dd/MM/yyyy").parse(film['date'] as String),
          accompagne: film['accompagne'] == null
              ? null
              : film['accompagne'] == 1
              ? true
              : false,
          personnes: film['personnes'] == null
              ? null
              : (film['personnes'] as String).split(','),
          cinemas: film['cinemas'] == null
              ? null
              : (film['cinemas'] as String).split(','),
        ),
      );
    }
    return listeFilm;
  }
}
