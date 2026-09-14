import 'dart:convert';
import 'package:culture_app1/commun/classes/class_serie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Les saisons (et leurs épisodes) sont imbriquées dans l'objet Serie : on les
// sérialise en JSON dans une seule colonne plutôt que de créer des tables
// liées, ce qui évite des jointures pour un usage strictement personnel.
class DbSerie {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'series1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE series1 (id INTEGER PRIMARY KEY, titre TEXT, genre TEXT, plateforme TEXT, annee INTEGER, createur TEXT, acteurs TEXT, description TEXT, avecQui TEXT, recommandePar TEXT, citations TEXT, nbSaisons INTEGER, nbEpisodesMoyen INTEGER, dureeMoyenneEpisode INTEGER, note DEC, saisons TEXT)',
        );
      },
    );
  }

  static Map<String, dynamic> _versLigne(Serie serie) {
    return {
      'titre': serie.titre,
      'genre': serie.genre?.join(','),
      'plateforme': serie.plateforme?.join(','),
      'annee': serie.annee,
      'createur': serie.createur,
      'acteurs': serie.acteurs?.join(','),
      'description': serie.description,
      'avecQui': serie.avecQui?.join(','),
      'recommandePar': serie.recommandePar?.join(','),
      'citations': serie.citations?.join(','),
      'nbSaisons': serie.nbSaisons,
      'nbEpisodesMoyen': serie.nbEpisodesMoyen,
      'dureeMoyenneEpisode': serie.dureeMoyenneEpisode,
      'note': serie.note,
      'saisons': jsonEncode(serie.saisons.map((s) => s.toMap()).toList()),
    };
  }

  static Future<int> insert(Serie serie) async {
    final db = await getDatabase();
    return await db.insert('series1', _versLigne(serie));
  }

  static Future<int> update(Serie serie) async {
    final db = await getDatabase();
    return await db.update(
      'series1',
      _versLigne(serie),
      where: 'id=?',
      whereArgs: [serie.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await getDatabase();
    return await db.delete('series1', where: 'id=?', whereArgs: [id]);
  }

  static Future<List<Serie>> getList() async {
    final db = await getDatabase();
    var listeData = await db.query('series1');
    List<Serie> listeSeries = [];
    for (var s in listeData) {
      listeSeries.add(
        Serie(
          id: s['id'] as int,
          titre: s['titre'] as String,
          genre: s['genre'] == null ? null : (s['genre'] as String).split(','),
          plateforme: s['plateforme'] == null
              ? null
              : (s['plateforme'] as String).split(','),
          annee: s['annee'] == null ? null : s['annee'] as int,
          createur: s['createur'] == null ? null : s['createur'] as String,
          acteurs: s['acteurs'] == null
              ? null
              : (s['acteurs'] as String).split(','),
          description: s['description'] == null
              ? null
              : s['description'] as String,
          avecQui: s['avecQui'] == null
              ? null
              : (s['avecQui'] as String).split(','),
          recommandePar: s['recommandePar'] == null
              ? null
              : (s['recommandePar'] as String).split(','),
          citations: s['citations'] == null
              ? null
              : (s['citations'] as String).split(','),
          nbSaisons: s['nbSaisons'] == null ? null : s['nbSaisons'] as int,
          nbEpisodesMoyen: s['nbEpisodesMoyen'] == null
              ? null
              : s['nbEpisodesMoyen'] as int,
          dureeMoyenneEpisode: s['dureeMoyenneEpisode'] == null
              ? null
              : s['dureeMoyenneEpisode'] as int,
          note: s['note'] == null
              ? null
              : s['note'] is int
              ? (s['note'] as int).toDouble()
              : s['note'] as double,
          saisons: s['saisons'] == null
              ? []
              : (jsonDecode(s['saisons'] as String) as List)
                    .map(
                      (m) => Saison.fromMap(Map<String, dynamic>.from(m as Map)),
                    )
                    .toList(),
        ),
      );
    }
    return listeSeries;
  }
}
